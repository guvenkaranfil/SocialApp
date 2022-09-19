//
//  FeedPresenter.swift
//  SocialApp
//
//  Created by Güven Karanfil on 19.09.2022.
//

import Foundation
import Combine

enum ViewState<T: Equatable>: Equatable {
    case loading
    case loaded(T)
    case error(message: String?)
}

class FeedInteractor {
    @Published var state: ViewState<[FeedItem]> = .loading
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

class FeedPresenter: ObservableObject {
    private let interactor: FeedInteractor
    private let router = FeedRouter()
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var state: ViewState<[FeedItem]> = .loading
    @Published var isPosting: Bool = false
    
    init(interactor: FeedInteractor) {
        self.interactor = interactor
        
        interactor.$state
            .assign(to: \.state, on: self)
            .store(in: &cancellables)
        
        interactor.$isPosting
            .assign(to: \.isPosting, on: self)
            .store(in: &cancellables)
    }
    
    func onAppear() {
        interactor.loadFeed()
    }
    
    func onSubmit(item: FeedItem) {
        self.interactor.postFeed(item)
    }
}
