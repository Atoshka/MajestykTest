//
//  APIRouter.swift
//  MajestykTest
//
//  Created by Ilya Borshchov on 13.02.2021.
//

import Foundation
import Alamofire

protocol APIRouter: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}

struct RestApiConstants {
    struct ServerProperties {
        static let baseUrl: String = "https://api.github.com"
    }
}

enum HTTPHeaderField: String {
    case authorization = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
}

enum Authorization: String {
    case accessToken = "f4275222372e02b7dc1a8192bf7fcfed7285aab7"
}
enum ContentType: String {
    case json = "application/json"
    case github = "application/vnd.github.v3+json"
}
