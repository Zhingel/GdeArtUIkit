//
//  User.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 17.11.2021.
//

import Foundation

struct User {
    let uid: String
    let userName: String
    let email: String
    let profileImage: String
    init (uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.userName = dictionary["userName"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.profileImage = dictionary["profileImageUrl"] as? String ?? ""
    }
}
