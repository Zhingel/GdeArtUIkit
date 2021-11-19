//
//  ViewModel.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 19.11.2021.
//

import Foundation
import FirebaseDatabase
class art: ObservableObject {
    @Published var tasks = [Task]()
    init() {
        fetchData()
    }
        func fetchData() {
            let ref = Database.database().reference()
            ref.child("posts").observeSingleEvent(of: .value) { snapshot in
                guard let dictionaries = snapshot.value as? [String: Any] else {return}
                dictionaries.forEach { key, value in
                    guard let dictionary = value as? [String: Any] else {return}
                    print(dictionary)
                    let post = Post(dictionary: dictionary)
                    let postWithId = Task(id: key, post: post, showText: false)
                    self.tasks.append(postWithId)
                }
            }
        }
}
struct Task: Identifiable {
    var id: String
    var post: Post
    var showText: Bool = false
}






//
//class art: ObservableObject {
//    
//    @Published var posts = [PostwithId]()
//    
////    func fetchData() {
////        let ref = Database.database().reference()
////        ref.child("posts").observeSingleEvent(of: .value) { snapshot in
////            guard let dictionaries = snapshot.value as? [String: Any] else {return}
////            dictionaries.forEach { key, value in
////                guard let dictionary = value as? [String: Any] else {return}
////                let post = Post(dictionary: dictionary)
////                let postWithId = PostwithId(post: post, key: key)
////                self.posts.append(postWithId)
////
////            }
////        }
////    }
//}
//
//struct PostwithId {
//    let post: Post2
//    let key: String
//}
//
//struct Post2 {
//    let userUid: String = "userUid"
//    let openCallName: String = "DAta7"
//    var curatorsName: String? = "curatorsName"
//    var instagrammLink: String? = "instagrammLink"
//    let description: String = "description"
//
//}
