//
//  DataLoader.swift
//  MajestykTest
//
//  Created by Ilya Borshchov on 14.02.2021.
//

import Foundation

enum LoaderState {
    case loading, success, failure
}

class DataLoader: ObservableObject {
    var data = Data()
    var state = LoaderState.loading

    init() { }
}

extension DataLoader {
    
    convenience init(url: String) {
        self.init()
        
        guard let parsedURL = URL(string: url) else {
            fatalError("Error! Invalid URL: \(url)")
        }

        URLSession.shared.dataTask(with: parsedURL) { data, response, error in
            if let data = data, data.count > 0 {
                self.data = data
                self.state = .success
            } else {
                self.state = .failure
            }

            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }.resume()
    }
    
    convenience init(request: URLRequest) {
        self.init()
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, data.count > 0 {
                self.data = data
                self.state = .success
            } else {
                self.state = .failure
            }

            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }.resume()
    }
}
