//
//  HTTPRequestManager+UserDetails.swift
//  MajestykTest
//
//  Created by Ilya Borshchov on 14.02.2021.
//

import Foundation
import Combine
import Alamofire

struct UserDetailsResponse: Codable, Identifiable {
    let id: UInt
    let login: String
    let email: String?
    let location: String?
    let createdAt: String
    let followers: Int?
    let following: Int?
    let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case email
        case location
        case createdAt = "created_at"
        case followers
        case following
        case avatarUrl = "avatar_url"
    }
}

protocol HTTPRequestManagerUserDetails {
    func getDetails(name: String) -> AnyPublisher<UserDetailsResponse, WrappedError>
}

extension HTTPRequestManager: HTTPRequestManagerUserDetails {
    func getDetails(name: String) -> AnyPublisher<UserDetailsResponse, WrappedError> {
        return AF.request(UserDetailsRouter.getDetails(userName: name))
            .publishDecodable(type: UserDetailsResponse.self)
            .value()
            .mapError{ return WrappedError.alamofire(wrapped: $0) }
            .map { $0 }
            .eraseToAnyPublisher()
    }
}
