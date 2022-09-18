//
//  FeedLoader.swift
//  SocialApp
//
//  Created by Güven Karanfil on 18.09.2022.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedItem])
    case failure(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
