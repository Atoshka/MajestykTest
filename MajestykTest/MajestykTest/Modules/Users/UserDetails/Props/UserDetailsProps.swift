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
    var name: String { get }
    var followersInfo: String { get }
    var followingInfo: String { get }
}

struct UserDetailsProps: UserDetailsPropsProtocol {
    static let initial = UserDetailsProps(imageUrl: nil, userName: "", email: "", location: "", name: "", followersInfo: "", followingInfo: "")
    
    let imageUrl: String?
    let userName: String
    let email: String
    let location: String
    let name: String
    let followersInfo: String
    let followingInfo: String
}

extension UserDetailsProps {
    init(with userDetailsModel: UserDetailsResponse) {
        
        self.imageUrl = userDetailsModel.avatarUrl
        self.userName = userDetailsModel.name ?? ""
        self.email = userDetailsModel.email ?? ""
        
        self.location = userDetailsModel.location ?? ""
        self.name = userDetailsModel.name ?? ""
        self.followersInfo = userDetailsModel.followers != nil ? "\(userDetailsModel.followers!) Followers" : "0 Followers"
        self.followingInfo = userDetailsModel.following != nil ? "Following \(userDetailsModel.following!)" : "Following 0"
    }
}
