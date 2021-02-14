//
//  UserDetailsProps.swift
//  MajestykTest
//
//  Created by Ilya Borshchov on 14.02.2021.
//

import Foundation

protocol UserDetailsPropsProtocol {
    var imageUrl: String? { get }
    var userName: String { get }
    var email: String { get }
    var location: String { get }
    var createdAt: String { get }
    var followersInfo: String { get }
    var followingInfo: String { get }
}

struct UserDetailsProps: UserDetailsPropsProtocol {
    static let initial = UserDetailsProps(imageUrl: nil, userName: "", email: "", location: "", createdAt: "", followersInfo: "", followingInfo: "")
    
    let imageUrl: String?
    let userName: String
    let email: String
    let location: String
    let createdAt: String
    let followersInfo: String
    let followingInfo: String
}

extension UserDetailsProps {
    init(with userDetailsModel: UserDetailsResponse) {
        
        self.imageUrl = userDetailsModel.avatarUrl
        self.userName = userDetailsModel.login
        self.email = userDetailsModel.email ?? ""
        
        var createdAt = ""
        if let date = DateFormatter.joinDateFormatter.date(from: userDetailsModel.createdAt) {
            createdAt = DateFormatter.readableDateFormatter.string(from: date)
        } else {
            assertionFailure("Error! Incorrect date format: \(userDetailsModel.createdAt)")
        }
        
        self.createdAt = createdAt
        self.location = userDetailsModel.location ?? ""
        
        self.followersInfo = userDetailsModel.followers != nil ? "\(userDetailsModel.followers!) Followers" : "0 Followers"
        self.followingInfo = userDetailsModel.following != nil ? "Following \(userDetailsModel.following!)" : "Following 0"
    }
}
