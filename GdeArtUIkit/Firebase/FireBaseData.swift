//
//  FireBaseData.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 05.12.2021.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

protocol FireBase {
    var tasks: [Task]? {get}
    func fetchPostsData()
    var user: String? {get}
    func auth()
    func fetchUserWithUID(uid: String, complition: @escaping (UIImage) ->())
}

class FirebaseDataNew: FireBase {
    var tasks: [Task]?
    var user: String?

    func auth() {
        user = "123"
    }
    
    func fetchPostsData() {
        let ref = Database.database().reference()
        var tasks = [Task]()
        ref.child("posts").observeSingleEvent(of: .value) { snapshot in
            guard let dictionaries = snapshot.value as? [String: Any] else {return}
            dictionaries.forEach { key, value in
                guard let dictionary = value as? [String: Any] else {return}
                print(dictionary)
                let post = Post(dictionary: dictionary)
                let postWithId = Task(id: key, post: post, showText: false)
                tasks.append(postWithId)
            }
            self.tasks = tasks
        }
    }
    
    
    
    
    
    func fetchUserWithUID(uid: String, complition: @escaping (UIImage) ->()) {
        print("with user", uid)
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let userDictionary = snapshot.value as? [String: Any] else {return}
            let user = User(uid: uid, dictionary: userDictionary)
                print("---------")
                print("---------")
                print("---------")
                print("---------")
                print(user.email)
                print(user.profileImage)
                let url = user.profileImage
            guard let imageURL = URL(string: url) else {return}
            URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                if let error = error {
                    print("Error fetch image", error)
                    return
                }
                guard let data = data else {return}
                guard let photoImage = UIImage(data: data) else {return}

                DispatchQueue.main.async {
                    complition(photoImage)
//                    self.plusPhotoButton.setImage(photoImage?.withRenderingMode(.alwaysOriginal), for: .normal)
                }

            }.resume()
          
        } withCancel: { err in
            print(err)
        }
           
    }
}
