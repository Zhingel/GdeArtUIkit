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
//    static var shared = FirebaseData()
    
//    func fetchUsers(comlition: @escaping ([User]) -> ()) {
//        var users = [User]()
//
//        let ref = Database.database().reference().child("users")
//        ref.observeSingleEvent(of: .value) { snapshot in
//            guard let dictionary = snapshot.value as? [String: Any] else {return}
//            dictionary.forEach { key, value in
//                guard let dictionaries = value as? [String: Any] else {return}
//                let user = User(uid: key, dictionary: dictionaries)
//                users.append(user)
//            }
//            comlition(users)
//        }
//
//    }
    func fetchUserWithUID(uid: String, completion: @escaping (User) -> ()) {
        print("with user", uid)
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let userDictionary = snapshot.value as? [String: Any] else {return}
            let user = User(uid: uid, dictionary: userDictionary)
            print(user.userName)
            completion(user)
        } withCancel: { err in
            print(err)
        }
    }
}
