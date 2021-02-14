//
//  RepoProps.swift
//  MajestykTest
//
//  Created by Ilya Borshchov on 14.02.2021.
//

import Foundation

protocol RepoPropsProtocol {
    var id: UUID { get }
    var name: String { get }
    var forks: String { get }
    var stars: String { get }
}

struct RepoProps: RepoPropsProtocol {
    var id: UUID = UUID()
    
    let name: String
    let forks: String
    let stars: String
    let url: String
}

extension RepoProps {
    init(with userRepoResponse: UserRepoResponse) {
        
        self.name = userRepoResponse.name
        self.forks = "\(userRepoResponse.forksCount) Forks"
        self.stars = "\(userRepoResponse.stargazersCount) Stars"
        self.url = userRepoResponse.htmlUrl
    }
}
