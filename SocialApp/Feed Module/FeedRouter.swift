//
//  FeedRouter.swift
//  SocialApp
//
//  Created by Güven Karanfil on 19.09.2022.
//

import SwiftUI

class FeedRouter {
    static func makeNavigationView(feedPresenter: FeedPresenter, usersViewModel: UsersViewModel) -> some View {
        NavigationLink(destination: PostFeed(feedPresenter: feedPresenter, usersViewModel: usersViewModel)) {
            Image(systemName: "plus")
                .foregroundColor(.secondary)
                .foregroundStyle(.primary)
        }
        .accessibilityIdentifier("postFeed")
    }
}
