//
//  HTTPRequestManager+UserList.swift
//  MajestykTest
//
//  Created by Ilya Borshchov on 14.02.2021.
//

import Foundation
import Combine
import Alamofire

struct UserListResponse: Codable {
    var totalCount: Int
    var incompleteResults: Bool
    var items: [UserCompactModel]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

struct UserCompactModel: Codable, Identifiable {
    let id: UInt
    let login: String
    let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarUrl = "avatar_url"
    }
}

protocol HTTPRequestManagerUserList {
    func searchUsers(string: String) -> AnyPublisher<[UserCompactModel], WrappedError>
}

extension HTTPRequestManager: HTTPRequestManagerUserList {
    func searchUsers(string: String) -> AnyPublisher<[UserCompactModel], WrappedError> {
        return AF.request(SearchUsersRouter.search(text: string))
            .publishDecodable(type: UserListResponse.self)
            .value()
            .mapError{ return WrappedError.alamofire(wrapped: $0) }
            .map { $0.items }
            .eraseToAnyPublisher()
    }
}
