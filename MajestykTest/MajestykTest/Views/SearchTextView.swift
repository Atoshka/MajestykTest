//
//  SearchTextView.swift
//  MajestykTest
//
//  Created by Ilya Borshchov on 14.02.2021.
//

import SwiftUI

struct SearchTextView: View {
    
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 5))
            .frame(width: UIScreen.main.bounds.width - 40, height: 45, alignment: .leading)
            .clipped()
            .cornerRadius(10)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                }
            )
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(Color("BorderColor"), lineWidth: 2)
            )
    }
}
