//
//  FeedViewModel.swift
//  SocialApp
//
//  Created by Güven Karanfil on 18.09.2022.
//

import Foundation

enum ViewState<T: Equatable>: Equatable {
    case loading
    case loaded(T)
    case error(message: String?)
}

final class FeedViewModel: ObservableObject {
    @Published var state: ViewState<[FeedItem]> = .loading

    private let loader: RemoteFeedLoader
    
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
                }
            case let .failure(error):
                self?.state = .error(message: error.localizedDescription)
            }
        }
    }
}
