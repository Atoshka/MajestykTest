//
//  RepoItemView.swift
//  MajestykTest
//
//  Created by Ilya Borshchov on 14.02.2021.
//

import SwiftUI

struct RepoItemView: View {
    
    var repoName: String
    var forks: String
    var stars: String
    
    var body: some View {
        HStack {
            
            Text(repoName)
            Spacer()
            
            VStack(alignment: .trailing, spacing: 3) {
                Text(forks)
                Text(stars)
            }
        }
        .padding()
    }
}
