//
//  FeedItem.swift
//  SocialApp
//
//  Created by Güven Karanfil on 18.09.2022.
//

import Foundation
import UIKit

public struct FeedItem: Equatable {
    public let id: UUID
    public let name: String
    public let username: String
    public let text: String
    public let imageURL: URL
    public let image: UIImage?
    
    public init(id: UUID, name: String, username: String, text: String, imageURL: URL, image: UIImage?) {
        self.id = id
        self.name = name
        self.username = username
        self.text = text
        self.imageURL = imageURL
        self.image = image
    }
}

extension FeedItem: Identifiable { }
