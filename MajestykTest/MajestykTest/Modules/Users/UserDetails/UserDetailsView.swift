//
//  UserDetailsView.swift
//  MajestykTest
//
//  Created by Ilya Borshchov on 14.02.2021.
//

import SwiftUI


struct UserDetailsView<ViewModel>: View where ViewModel: UserDetailsViewModelProtocol {
    
    @EnvironmentObject var viewModel: ViewModel
    
    private var imageSize: CGFloat = UIScreen.main.bounds.size.width / 2 - 40
    
    var body: some View {
        VStack {
            HStack(spacing: 30) {
                if (viewModel.userDetails.imageUrl != nil) {
                    RemoteAsyncImageView(url: viewModel.userDetails.imageUrl!)
                        .scaledToFill()
                        .frame(width: imageSize, height: imageSize)
                } else {
                    Rectangle()
                        .background(Color(UIColor.gray))
                        .frame(width: imageSize, height: imageSize)
                }
                
                VStack(alignment: HorizontalAlignment.leading, spacing: 4) {
                    Text(viewModel.userDetails.userName)
                    Text(viewModel.userDetails.email)
                    Text(viewModel.userDetails.location)
                    Text(viewModel.userDetails.name)
                    Text(viewModel.userDetails.followersInfo)
                    Text(viewModel.userDetails.followingInfo)
                }
            }
            .padding()
            
            SearchTextView(placeholder: "Search user repos", text: $viewModel.repoSearchString)
            
            if viewModel.repositories.count > 0 {
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: [GridItem(.flexible())], content: {
                        ForEach(viewModel.repositories, id: \.id) { repo in
                            RepoItemView(repoName: repo.name, forks: repo.forks, stars: repo.stars).onTapGesture {
                                viewModel.didSelectRepo(withName: repo.name)
                            }
                        }
                    })
                }
            } else {
                Color.clear
            }
        }
        .onAppear {
            viewModel.viewAppeared()
        }
        .navigationTitle("User Details")
    }
}
