//
//  ReposNumberTextView.swift
//  MajestykTest
//
//  Created by Ilya Borshchov on 14.02.2021.
//

import SwiftUI

struct ReposNumberTextView: View {
    
    private struct UserInfo: Decodable {

        let publicRepos: Int
        
        enum CodingKeys: String, CodingKey {
            case publicRepos = "public_repos"
        }
    }
    
    @StateObject private var loader: DataLoader
    var placeholder: String
    
    var body: some View {
        selectData()
    }

    init(url: String, placeholder: String) {
        _loader = StateObject(wrappedValue: DataLoader(url: url))
        self.placeholder = placeholder
    }

    private func selectData() -> Text {
        switch loader.state {
        case .loading:
            return Text(placeholder)
        case .failure:
            return Text("")
        default:
            
            let object = try? JSONDecoder().decode(UserInfo.self, from: loader.data)
            
            if let obj = object {
                return Text(String("\(obj.publicRepos)"))
            } else {
                return Text("Error!")
            }
        }
    }
}

extension ReposNumberTextView {
    init(request: URLRequest, placeholder: String) {
        _loader = StateObject(wrappedValue: DataLoader(request: request))
        self.placeholder = placeholder
    }
}
