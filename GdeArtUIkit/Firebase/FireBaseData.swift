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
import SwiftUI

protocol FireBase {
    var tasks: [Task] {get}
    func fetchPostsData()
    func fetchUserWithUID(uid: String, complition: @escaping (User) -> ())
    func addPost(values: [String: Any], complition: @escaping () -> ())
    func uploadImageToFireStore(uid: String, image: UIImage)
    func fetchImageWithURL(urlString: String, complition: @escaping (UIImage) ->())
}

class FirebaseDataNew: FireBase, ObservableObject {
    @Published var tasks = [Task]()

 
    
    func fetchPostsData() {
        let ref = Database.database().reference()
        var tasks = [Task]()
        ref.child("posts").observeSingleEvent(of: .value) { snapshot in
            guard let dictionaries = snapshot.value as? [String: Any] else {return}
            dictionaries.forEach { key, value in
                guard let dictionary = value as? [String: Any] else {return}
                let post = Post(dictionary: dictionary)
                let postWithId = Task(id: key, post: post, showText: false)
                tasks.append(postWithId)
            }
            self.tasks = tasks
            print(tasks)
            
        }
        
    }
    

    
    func addPost(values: [String: Any], complition: @escaping () -> ()) {
        Database.database().reference().child("posts").childByAutoId().updateChildValues(values) { (err, ref) in
            if let err = err {
                print("Failed", err)
                return
            }
            print("Successfuly save to db")
//            NotificationCenter.default.post(name: NSNotification.newPost,
//                                            object: nil,
//                                            userInfo: nil)
            self.tasks.removeAll()
            self.fetchPostsData()
            complition()
        }
    }
    
    func uploadImageToFireStore(uid: String, image: UIImage) {
        guard let uploadData = image.jpegData(compressionQuality: 0.3) else {return}
        let fileName = "profileImageUID_" + uid
        let storageRef = Storage.storage().reference().child("profile_images").child(uid).child(fileName)
        storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
            if error != nil {
                print("failed to upload data")
                return
            }
            storageRef.downloadURL(completion: { (url, error) in
                    if error != nil {
                        print(error!.localizedDescription)
                        return
                    }
                    if let profileImageUrl = url?.absoluteString {
                        print("Success")
                        guard let user = Auth.auth().currentUser else {return}
                        let uid = user.uid
                        
                        let dictionaryValues = ["profileImageUrl" : profileImageUrl]
                        Database.database().reference().child("users").child(uid).updateChildValues(dictionaryValues) { (err, ref) in
                            if let err = err {
                                print("error to safe user info in database", err)
                                return
                            }
                            print("successfuly save user")
                           
                        }
                    }
                })
        }
    }
    func deleteImageFromFireStore(imageName: String) {
//        // Create a reference to the file to delete
//        let storageRef = Storage.storage().reference().child("profile_images").
//
//        // Delete the file
//        desertRef.delete { error in
//          if let error = error {
//            // Uh-oh, an error occurred!
//          } else {
//            // File deleted successfully
//          }
//        }
    }
    func fetchUserWithUID(uid: String, complition: @escaping (User) -> ()) {
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let userDictionary = snapshot.value as? [String: Any] else {return}
            let user = User(uid: uid, dictionary: userDictionary)
            complition(user)
        } withCancel: { err in
            print(err)
        }
    }
    func fetchImageWithURL(urlString: String, complition: @escaping (UIImage) ->()) {
        guard let imageURL = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if let error = error {
                print("Error fetch image", error)
                return
            }
            guard let data = data else {return}
            guard let photoImage = UIImage(data: data) else {return}

            DispatchQueue.main.async {
                complition(photoImage)
            }

        }.resume()
    }
}
