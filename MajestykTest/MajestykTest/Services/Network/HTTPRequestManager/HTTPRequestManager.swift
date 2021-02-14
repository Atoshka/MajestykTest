//
//  HTTPRestManager.swift
//  MajestykTest
//
//  Created by Ilya Borshchov on 13.02.2021.
//

import Foundation
import Alamofire

class HTTPRequestManager {
    
    static var sharedInstance = HTTPRequestManager()
}

enum WrappedError: Error {
    case alamofire(wrapped: AFError)
}


