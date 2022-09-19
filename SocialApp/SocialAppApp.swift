//
//  SocialAppApp.swift
//  SocialApp
//
//  Created by Güven Karanfil on 18.09.2022.
//

import SwiftUI

@main
struct SocialAppApp: App {
    var body: some Scene {
        WindowGroup {
            let url = URL(string: "https://jsonblob.com/api/jsonBlob/1021062556189736960")!
            let session = URLSession(configuration: .ephemeral)
            let client = URLSessionHTTPClient(session: session)
            let feedLoader = RemoteFeedLoader(client: client, url: url)
            
            
            let usersViewModal = UsersViewModel()
            let feedViewModel = FeedViewModel(loader: feedLoader)
            NavigationView {
                FeedViewList(feedViewModel: feedViewModel)
                    .navigationTitle("Posts")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            UsersMenu(usersViewModel: usersViewModal)
                        }
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                print("Pressed")
                            } label: {
                                Image(systemName: "plus")
                                    .foregroundColor(.secondary)
                                    .foregroundStyle(.primary)
                            }
                        }
                    }
            }
        }
    }
}

