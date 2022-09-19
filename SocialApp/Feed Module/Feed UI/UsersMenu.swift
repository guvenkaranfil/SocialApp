//
//  HeaderBar.swift
//  SocialApp
//
//  Created by Güven Karanfil on 19.09.2022.
//

import SwiftUI

struct UsersMenu: View {
    @ObservedObject var postInteractor: PostInteractor
    
    init(postInteractor: PostInteractor) {
        self.postInteractor = postInteractor
    }
    
    var body: some View {
        Menu(self.postInteractor.currentUser!.username) {
            let otherUsers = self.postInteractor.users.filter { user in
                return user.username != self.postInteractor.currentUser?.username
            }
            ForEach(otherUsers) { user in
                Button(user.username) {
                    self.postInteractor.select(user)
                }
            }
        }
        .foregroundColor(.gray)
        .font(.headline)
    }
}

struct UsersMenu_Previews: PreviewProvider {
    static var previews: some View {
        UsersMenu(postInteractor: PostInteractor())
    }
}
