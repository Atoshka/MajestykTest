//
//  UserListViewModel.swift
//  MajestykTest
//
//  Created by Ilya Borshchov on 13.02.2021.
//

import Foundation
import Combine

final class UserListViewModel: UserListViewModelProtocol {
    
    @Published var searchString: String = ""
    @Published var users: [UserCompactModel] = []
    
    private var subscriptions: Set<AnyCancellable> = []
    private var restManager: HTTPRequestManagerUserList
    
    private init(restManager: HTTPRequestManagerUserList) {
        
        self.restManager = restManager
        
        $searchString
            .debounce(for: .milliseconds(1000), scheduler: RunLoop.main)
            .removeDuplicates()
            .map { string -> String? in
                if string.count < 2 {
                    self.users = []
                    return nil
                }
                return string
            }
            .compactMap { $0 }
            .sink {_ in
                
            } receiveValue: { [weak self] searchBy in
                self?.searchItems(by: searchBy)
            }
            .store(in: &subscriptions)
    }
    
    func viewAppeared() { }
    
    func viewDissapeared() { }
    
    private func searchItems(by text: String) {
        restManager.searchUsers(string: text)
            .sink { _ in
                
            } receiveValue: { users in
                DispatchQueue.main.async {
                    self.users = users
                }
            }
            .store(in: &subscriptions)
    }
}

extension UserListViewModel {
    public static func make() -> UserListViewModel {
        
        guard
            let restManager = AppDIConfigurator.resolve(service: HTTPRequestManager.self, name: .httpRequestManager) else {
            fatalError("Error! Expected Rest manager to be present")
        }
        
        return UserListViewModel(restManager: restManager)
    }
}
