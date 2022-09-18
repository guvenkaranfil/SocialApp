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

struct LoadingView: View {
    
    @State private var scale: CGFloat = 0
    @State private var opacity: Double = 0
    
    var body: some View {
        let animation = Animation
            .easeOut(duration: 1.25)
            .repeatForever(autoreverses: false)
        
        Circle()
            .scaleEffect(scale)
            .opacity(opacity)
            .onAppear {
                scale = 0
                opacity = 1
                withAnimation(animation) {
                    scale = 1
                    opacity = 0
                }
            }
    }
}


extension Color {
    init(_ hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
            case 3:
                (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6:
                (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8:
                (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
