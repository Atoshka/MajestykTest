//
//  UserReposRouter.swift
//  MajestykTest
//
//  Created by Ilya Borshchov on 14.02.2021.
//

import Foundation
import Alamofire

enum UserReposRouter: APIRouter {
    case getRepos(userName: String)
    
    var method: HTTPMethod {
        switch self {
        case .getRepos:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getRepos(let userName):
            return "/users/\(userName)/repos"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getRepos:
            return nil
        }
    }
    
    var url: String? {
        switch self {
        case .getRepos:
            
            let url = try? RestApiConstants.ServerProperties.baseUrl.asURL()
            if let url = url {
                return url.appendingPathComponent(path).absoluteString
            }
            
            return nil
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
