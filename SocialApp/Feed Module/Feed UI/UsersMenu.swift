//
//  HeaderBar.swift
//  SocialApp
//
//  Created by Güven Karanfil on 19.09.2022.
//

import SwiftUI

struct UsersMenu: View {
    @ObservedObject var usersViewModel: UsersViewModel
    
    init(usersViewModel: UsersViewModel) {
        self.usersViewModel = usersViewModel
    }
    
    var body: some View {
        Menu(self.usersViewModel.currentUser!.username) {
            let otherUsers = self.usersViewModel.users.filter { user in
                return user.username != self.usersViewModel.currentUser?.username
            }
            ForEach(otherUsers) { user in
                Button(user.username) {
                    self.usersViewModel.select(user)
                }
            }
        }
        .foregroundColor(.gray)
        .font(.headline)
    }
}

struct UsersMenu_Previews: PreviewProvider {
    static var previews: some View {
        UsersMenu(usersViewModel: UsersViewModel())
    }
}
