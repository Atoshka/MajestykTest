//
//  UserDetailsViewModel.swift
//  MajestykTest
//
//  Created by Ilya Borshchov on 14.02.2021.
//

import Foundation
import Combine
import UIKit


protocol UserDetailsViewModelProtocol: ObservableObject & ViewModelProtocol {
    
    var userDetails: UserDetailsPropsProtocol { get }
    var repoSearchString: String { get set }
    var repositories: [RepoPropsProtocol] { get }
    
    func didSelectRepo(withName name: String)
}

final class UserDetailsViewModel: UserDetailsViewModelProtocol {
    
    @Published var userDetails: UserDetailsPropsProtocol = UserDetailsProps.initial
    @Published var repoSearchString: String = ""
    @Published var repositories: [RepoPropsProtocol] = []
    
    private var initialRepoList: [RepoProps] = []
    private var userName: String
    private var subscriptions: Set<AnyCancellable> = []
    private var restManager: HTTPRequestManagerUserDetails & HTTPRequestManagerUserRepos
    
    private init(userName: String, restManager: HTTPRequestManagerUserDetails & HTTPRequestManagerUserRepos) {
        
        self.userName = userName
        self.restManager = restManager
        
        $repoSearchString
            .debounce(for: .milliseconds(100), scheduler: RunLoop.main)
            .removeDuplicates()
            .map { string -> String? in
                if string.count < 1 {
                    self.repositories = self.initialRepoList
                    return nil
                }
                return string
            }
            .compactMap { $0 }
            .map { searchString in
                self.initialRepoList.filter { $0.name.lowercased().contains(searchString.lowercased()) }
            }
            .sink {_ in

            } receiveValue: { [weak self] filtered in
                self?.repositories = filtered
            }
            .store(in: &subscriptions)
    }
    
    func didSelectRepo(withName name: String) {
        let stringUrl = self.initialRepoList.filter { $0.name == name }.first?.url
        
        if let stringUrl = stringUrl {
            guard let url = URL(string: stringUrl)  else {
                assertionFailure("Error! Can't create url from \(stringUrl)")
                return
            }
            
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } else {
            assertionFailure("Error! URL should not be nil")
            return
        }
    }
    
    func viewAppeared() {
        restManager.getDetails(name: userName)
            .sink { _ in
                
            } receiveValue: { [weak self] userResponse in
                self?.userDetails = UserDetailsProps.init(with: userResponse)
            }
            .store(in: &subscriptions)
        
        restManager.getReposBy(userName: userName)
            .map { $0.map { RepoProps(with: $0) } }
            .sink { _ in
                
            } receiveValue: { [weak self] repos in
                self?.initialRepoList = repos
                self?.repositories = repos
            }
            .store(in: &subscriptions)
    }
    
    func viewDissapeared() { }
}

extension UserDetailsViewModel {
    public static func make(userName: String) -> UserDetailsViewModel {
        
        guard
            let restManager = AppDIConfigurator.resolve(service: HTTPRequestManager.self, name: .httpRequestManager) else {
            fatalError("Error! Expected Rest manager to be present")
        }
        
        return UserDetailsViewModel(userName: userName, restManager: restManager)
    }
}
