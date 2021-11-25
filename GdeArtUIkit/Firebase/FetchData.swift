//
//  FetchData.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 25.11.2021.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class FirebaseData {
    static var shared = FirebaseData()
    
    func fetchUsers() -> [User] {
        var users = [User]()
        let ref = Database.database().reference().child("users")
        ref.observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            dictionary.forEach { key, value in
                guard let dictionaries = value as? [String: Any] else {return}
                let user = User(uid: key, dictionary: dictionaries)
                users.append(user)
            }
        }
        return users
    }
}
