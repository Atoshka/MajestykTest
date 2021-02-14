//
//  HTTPRequestManager+Repos.swift
//  MajestykTest
//
//  Created by Ilya Borshchov on 14.02.2021.
//

import Foundation
import Alamofire
import Combine

struct UserReposResponse {
    
}

struct UserRepoResponse: Decodable {
    let id: Int
    let name: String
    let forksCount: Int
    let stargazersCount: Int
    let htmlUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case forksCount = "forks_count"
        case stargazersCount = "stargazers_count"
        case htmlUrl = "html_url"
    }
}


protocol HTTPRequestManagerUserRepos {
    func getReposBy(userName: String) -> AnyPublisher<[UserRepoResponse], WrappedError>
}

extension HTTPRequestManager: HTTPRequestManagerUserRepos {
    func getReposBy(userName: String) -> AnyPublisher<[UserRepoResponse], WrappedError> {
        return AF.request(UserReposRouter.getRepos(userName: userName))
            .publishDecodable(type: [UserRepoResponse].self)
            .value()
            .mapError{ return WrappedError.alamofire(wrapped: $0) }
            .map { $0 }
            .eraseToAnyPublisher()
    }
}
