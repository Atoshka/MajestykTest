//
//  UserListViewModelProtocol.swift
//  MajestykTest
//
//  Created by Ilya Borshchov on 13.02.2021.
//

import Foundation
import Combine

protocol UserListViewModelProtocol: ObservableObject & ViewModelProtocol {
    
    var searchString: String { get set }
    
}
