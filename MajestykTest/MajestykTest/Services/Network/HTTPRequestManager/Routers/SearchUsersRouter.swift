//
//  UserReposRouter.swift
//  MajestykTest
//
//  Created by Ilya Borshchov on 13.02.2021.
//

import Foundation
import Alamofire

enum SearchUsersRouter: APIRouter {
    case search(text: String)
    
    var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .search:
            return "/search/users"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .search(let text):
            return ["q": text]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let url = try RestApiConstants.ServerProperties.baseUrl.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.setValue(ContentType.github.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue("token \(Authorization.accessToken.rawValue)", forHTTPHeaderField: HTTPHeaderField.authorization.rawValue)
        
        if let parameters = parameters {
            
            switch method {
            case .get:
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
                break
            default:
                assertionFailure("Error! Not implemented yet")
                break
            }
        }
        
        return urlRequest
    }
}
