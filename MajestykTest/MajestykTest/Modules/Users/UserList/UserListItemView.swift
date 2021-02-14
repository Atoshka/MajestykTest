//
//  UserListItemView.swift
//  MajestykTest
//
//  Created by Ilya Borshchov on 13.02.2021.
//

import SwiftUI

struct UserListItemView: View {
    
    var imageUrl: String?
    var userName: String
    
    var body: some View {
        HStack {
            if imageUrl != nil {
                RemoteAsyncImageView(url: imageUrl!)
                    .scaledToFill()
                    .frame(width: 50.0, height: 50.0)
            } else {
                Rectangle()
                    .background(Color(UIColor.gray))
                    .frame(width: 50.0, height: 50.0)
            }
            
            Text(userName)
            Spacer()
            if let request = try? UserDetailsRouter.getDetails(userName: userName).asURLRequest() {
                ReposNumberTextView(request: request, placeholder: "Loading...")
            } else {
                Text("Can't load repos info")
            }
        }
        .padding()
    }
}

