//
//  UserListView.swift
//  MajestykTest
//
//  Created by Ilya Borshchov on 13.02.2021.
//

import SwiftUI

struct UserListView<ViewModel>: View where ViewModel: UserListViewModelProtocol {
    
    @StateObject var viewModel = UserListViewModel.make()
    
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    SearchTextView(placeholder: "Type user name", text: $viewModel.searchString)
                }
                
                if viewModel.users.count > 0 {
                    ScrollView(showsIndicators: false) {
                    
                        LazyVGrid(columns: [GridItem(.flexible())], content: {
                            ForEach(viewModel.users) { user in
                                NavigationLink(destination: UserDetailsView<UserDetailsViewModel>()
                                                .environmentObject(UserDetailsViewModel.make(userName: user.login))) {
                                    
                                    UserListItemView(imageUrl: user.avatarUrl, userName: user.login)
                                }
                            }
                        })
                    }
                } else {
                    Color.clear
                }
            }
            .navigationTitle("GitHub Searcher")
        }
    }
}
