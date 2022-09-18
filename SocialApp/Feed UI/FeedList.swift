//
//  FeedList.swift
//  SocialApp
//
//  Created by Güven Karanfil on 19.09.2022.
//

import Foundation
import SwiftUI

struct FeedViewList: View {
    @StateObject var feedViewModel: FeedViewModel
    
    var body: some View {
        GeometryReader { geometry in
            Group {
                switch feedViewModel.state {
                case .loading:
                    VStack() {
                        LoadingView()
                            .frame(width: 50.0, height: 50.0)
                            .foregroundColor(Color("3dc6a7"))
                            .onAppear(perform: feedViewModel.loadFeed)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                    
                
                case let .loaded(feedItems) where !feedItems.isEmpty:
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(feedItems) { feed in
                                FeedCard(geometry: geometry, feed: feed)
                                .frame(width: geometry.size.width, height: 350)
                            }
                        }
                    }
                    
                case .loaded:
                    VStack(alignment: .center) {
                        Text("Something went wrong!\nPlease try again")
                    }
                    
                    
                default: EmptyView()
                }
            }
        }
    }
}
