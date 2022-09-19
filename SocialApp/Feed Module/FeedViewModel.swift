//
//  FeedViewModel.swift
//  SocialApp
//
//  Created by Güven Karanfil on 18.09.2022.
//

import Foundation

enum ViewState2<T: Equatable>: Equatable {
    case loading
    case loaded(T)
    case error(message: String?)
}

final class FeedViewModel: ObservableObject {
    @Published var state: ViewState2<[FeedItem]> = .loading
    @Published var isPosting: Bool = false

    private let loader: RemoteFeedLoader
    private var feedItems = [FeedItem]()
    
    init(loader: RemoteFeedLoader) {
        self.loader = loader
    }
    
    func loadFeed() {
        state = .loading
        loader.load { [weak self] result in
            switch result {
            case let .success(items):
                DispatchQueue.main.async {
                    self?.state = .loaded(items)
                    self?.feedItems = items
                }
            case let .failure(error):
                self?.state = .error(message: error.localizedDescription)
            }
        }
    }
    
    func postFeed(_ item: FeedItem) {
        self.state = .loading
        self.isPosting = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.feedItems.insert(item, at: 0)
            
            DispatchQueue.main.async {
                self.state = .loaded(self.feedItems)
            }
            
            self.isPosting = false
        }
    }
}
