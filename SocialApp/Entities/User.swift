//
//  User.swift
//  SocialApp
//
//  Created by Güven Karanfil on 19.09.2022.
//

import Foundation
import UIKit

public struct User: Identifiable {
    public let id: UUID
    public let name: String
    public let username: String
    public let profileIcon: String
    public let image: UIImage
}
