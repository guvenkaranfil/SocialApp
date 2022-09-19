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
