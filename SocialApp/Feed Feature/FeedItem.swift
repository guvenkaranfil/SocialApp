//
//  FeedItem.swift
//  SocialApp
//
//  Created by Güven Karanfil on 18.09.2022.
//

import Foundation

public struct FeedItem: Equatable {
    public let id: UUID
    public let name: String
    public let username: String
    public let text: String
    public let imageURL: URL
    
    public init(id: UUID, name: String, username: String, text: String, imageURL: URL) {
        self.id = id
        self.name = name
        self.username = username
        self.text = text
        self.imageURL = imageURL
    }
}
