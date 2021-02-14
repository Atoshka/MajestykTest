//
//  DIConfigurator.swift
//  MajestykTest
//
//  Created by Ilya Borshchov on 14.02.2021.
//

import Foundation
import Swinject


public enum Dependencies: String {
    
    case httpRequestManager
}

public class AppDIConfigurator {
    
    private static let container = Container()
    
    public static func register<T>(name: Dependencies, value: T) {
        container.register(type(of: value), name: name.rawValue) { _ in
            return value
        }
    }
    
    public static func resolve<T>(service: T.Type, name: Dependencies) -> T? {
        return container.resolve(service, name: name.rawValue)
    }
}
