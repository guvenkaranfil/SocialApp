//
//  FeedItem.swift
//  SocialApp
//
//  Created by Güven Karanfil on 18.09.2022.
//

import Foundation

public struct FeedItem: Equatable {
    let id: UUID
    let name: String
    let username: String
    let text: String
    let imageURL: URL
}
