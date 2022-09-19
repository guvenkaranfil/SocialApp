//
//  FeedRouter.swift
//  SocialApp
//
//  Created by Güven Karanfil on 19.09.2022.
//

import SwiftUI

class FeedRouter {
    static func makeNavigationView(feedPresenter: FeedPresenter, postInteractor: PostInteractor) -> some View {
        NavigationLink(destination: PostFeed(feedPresenter: feedPresenter, postInteractor: postInteractor)) {
            Image(systemName: "plus")
                .foregroundColor(.secondary)
                .foregroundStyle(.primary)
        }
        .accessibilityIdentifier("postFeed")
    }
}
