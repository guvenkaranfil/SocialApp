//
//  PostInteractor.swift
//  SocialApp
//
//  Created by Güven Karanfil on 19.09.2022.
//

import Foundation
import UIKit

class PostInteractor: ObservableObject {
    public let users: [User] = [
        User(id: UUID(), name: "John", username: "@stoneJohn", profileIcon: "square.and.pencil", image: UIImage(systemName: "house")!),
        User(id: UUID(), name: "Mia", username: "@wongMia", profileIcon: "square.and.pencil", image: UIImage(systemName: "externaldrive.badge.plus")!),
        User(id: UUID(), name: "Natalie", username: "@leeNatalie", profileIcon: "square.and.pencil", image: UIImage(systemName: "doc")!)
    ]
    @Published var currentUser: User?
    
    init() {
        self.currentUser = self.users.first
    }
    
    func select(_ user: User) {
        self.currentUser = user
    }
}
