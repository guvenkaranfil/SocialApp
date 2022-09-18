//
//  RemoteFeedLoader.swift
//  SocialApp
//
//  Created by Güven Karanfil on 18.09.2022.
//

import Foundation

public class RemoteFeedLoader: FeedLoader {
    let client: HTTPClient
    let url: URL
    
    public init(client: HTTPClient, url: URL) {
        self.client = client
        self.url = url
    }
    
    public typealias Result = LoadFeedResult<Error>
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public func load(completion: @escaping (Result) -> Void  ) {
        client.get(from: url) { [weak self] result in
            guard self != nil else {  return }
            
            switch result {
            case let .success(data, response):
                completion(FeedItemsMapper.map(data, from: response))
            case .failure:
                completion(.failure(.connectivity))
            }
        }
    }
}
