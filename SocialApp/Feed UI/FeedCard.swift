//
//  FeedCard.swift
//  SocialApp
//
//  Created by Güven Karanfil on 18.09.2022.
//

import SwiftUI

struct FeedCard: View {
    let geometry: GeometryProxy
    let feed: FeedItem
    
    init(geometry: GeometryProxy, feed: FeedItem) {
        self.geometry = geometry
        self.feed = feed
    }
    
    var body: some View {
            HStack(alignment: .top) {
                Image(systemName: "square.and.pencil")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(self.feed.name)
                            .font(.title)
                            .bold()
                        Text("@"+self.feed.username)
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                    
                    Text(self.feed.text)
                        .lineLimit(3)
                        .padding(.trailing)
                    
                    if (self.feed.image != nil) {
                        Image(uiImage: self.feed.image!)
                            .frame(width: geometry.size.width / 1.5, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .aspectRatio(contentMode: .fit)
                    } else {
                        AsyncImage(url: self.feed.imageURL)
                            .frame(width: geometry.size.width / 1.5, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .aspectRatio(contentMode: .fit)
                    }
                }
            }
    }
}

struct FeedCard_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            let feed = FeedItem(
                id: UUID(),
                name: "a name",
                username: "ausername",
                text: "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum ",
                imageURL: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHCj1m8wirjuacH_P9sphVIKKnsY6KSI2Y3A&usqp=CAU")!,
            image: nil)
            FeedCard(geometry: geometry, feed: feed)
        }
    }
}
