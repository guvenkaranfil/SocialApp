//
//  SocialAppTests.swift
//  SocialAppTests
//
//  Created by Güven Karanfil on 18.09.2022.
//

import XCTest


class RemoteFeedLoader {
    let client: HTTPClient
    let url: URL
    
    init(client: HTTPClient, url: URL) {
        self.client = client
        self.url = url
    }
    
    func load() {
        client.get(from: url)
    }
}

protocol HTTPClient {
    func get(from url: URL)
}

class SocialAppTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClientSpy()
        let url = URL(string: "https://any-url.com")!
        let _ = RemoteFeedLoader(client: client, url: url)
        
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        let client = HTTPClientSpy()
        let url = URL(string: "https://any-url.com")!
        let sut = RemoteFeedLoader(client: client, url: url)
        
        sut.load()
        
        XCTAssertEqual(url, client.requestedURL)
    }
    
    
    // MARK: - Helpers
    
    private class HTTPClientSpy: HTTPClient {
        var requestedURL: URL?
        
        func get(from url: URL) {
            requestedURL = url
        }
    }
}
