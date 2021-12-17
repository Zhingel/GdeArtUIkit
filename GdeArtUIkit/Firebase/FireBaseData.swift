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
    var tasks: [Task] {get}
    func fetchPostsData(complition: @escaping (Task) -> ())
    func fetchSelectedPost(selectedPost: String, complition: @escaping (Post) -> ()) 
    func fetchComments(postId: String)
    func addCommentFunc(commentTextDelegate: String, postId: String)
    func fetchUserWithUID(uid: String, complition: @escaping (User) -> ())
    func addPost(values: [String: Any], postId: String, complition: @escaping () -> ())
    func uploadImageToFireStore(uid: String, image: UIImage)
    func fetchImageWithURL(urlString: String, complition: @escaping (UIImage) ->())
    func savedToFavorites(hasSaved: Bool, postId: String)
}

class FirebaseDataNew: FireBase, ObservableObject { /// ????
    @Published var tasks = [Task]()
    @Published var comments = [Comment]()
    

//MARK: - FeedPosts:
    func fetchPostsData(complition: @escaping (Task) -> ()) {
        let ref = Database.database().reference()
        ref.keepSynced(true)
        ref.child("posts").observeSingleEvent(of: .value) { snapshot in
            guard let dictionaries = snapshot.value as? [String: Any] else {return}
            dictionaries.forEach { key, value in
                guard let dictionary = value as? [String: Any] else {return}
                let post = Post(dictionary: dictionary)
                var postWithId = Task(id: key, post: post, showText: false)
                if let userUID = AutorizationFireBase.auth.currentUser?.uid {
                    Database.database().reference().child("favorites").child(userUID).child(key).observeSingleEvent(of: .value) { snapshot in
                        if let value = snapshot.value as? Int, value == 1 {
                            postWithId.savedCall = true
                        } else {
                            postWithId.savedCall = false
                        }
                        self.tasks.append(postWithId)
                        complition(postWithId)
                    }
                } else {
                    self.tasks.append(postWithId)
                    complition(postWithId)
                }
            }
        }
    }
    func fetchSelectedPost(selectedPost: String, complition: @escaping (Post) -> ()) {
        let ref = Database.database().reference().child("posts").child(selectedPost)
        ref.observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            let post = Post(dictionary: dictionary)
            complition(post)
        }
    }
  
    func savedToFavorites(hasSaved: Bool, postId: String) {
        guard let uid = AutorizationFireBase.auth.currentUser?.uid else {return}
        let values = [postId : hasSaved == true ? 1 : 0]
        Database.database().reference().child("favorites").child(uid).updateChildValues(values)
    }
    
    
//MARK: - UserProfile:
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
    
    func fetchUserWithUID(uid: String, complition: @escaping (User) -> ()) {
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let userDictionary = snapshot.value as? [String: Any] else {return}
            let user = User(uid: uid, dictionary: userDictionary)
            complition(user)
        } withCancel: { err in
            print(err)
        }
    }
    
    
//MARK: - Comments:
    func addCommentFunc(commentTextDelegate: String, postId: String) {
        guard let uid = AutorizationFireBase.auth.currentUser?.uid else {return}
        let comment = ["text" : commentTextDelegate, "creationDate" : Date().timeIntervalSince1970, "uid": uid] as [String : Any]
        let ref = Database.database().reference().child("comments").child(postId).childByAutoId()
        ref.updateChildValues(comment)
        comments.removeAll()
        fetchComments(postId: postId)
    }
    func fetchComments(postId: String) {
        let ref = Database.database().reference().child("comments").child(postId)
        ref.keepSynced(true)
        ref.observeSingleEvent(of: .value) { snapshot in
            guard let dictionaries = snapshot.value as? [String: Any] else {return}
            dictionaries.forEach { key, value in
                guard let dictionary = value as? [String: Any] else {return}
                let comment = Comment(commentId: key, dictionary: dictionary)
                self.comments.append(comment)
            }
            print(self.comments)
            self.comments.sort {(p1, p2) -> Bool in
                return p1.creationDate.compare(p2.creationDate)  == .orderedDescending
            }
        }
        
    }
    
    
    
//MARK: - New Post:
    func addPost(values: [String: Any], postId: String, complition: @escaping () -> ()) {
        Database.database().reference().child("posts").child(postId).updateChildValues(values) { (err, ref) in
            if let err = err {
                print("Failed", err)
                return
            }
            print("Successfuly save to db")
//            NotificationCenter.default.post(name: NSNotification.newPost,
//                                            object: nil,
//                                            userInfo: nil)
//            self.tasks.removeAll()
//            self.fetchPostsData()
            complition()
        }
    }
    
//MARK: - Another:
    
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
}


//MARK: - ?????????
    // не смог прокинуть это через ServiceLocator и передать эти данные в SwiftUIView
    // данные выкачиваются на данный момент при помощи  .onAppear, но тогда они каждый раз перезакачиваются при показе вью, неуверен что так правильно, хотел бы использовать кэш своих [Post]
    // вообще не понимаю в какой момент должна осуществляться закачка данных при создании соцсети, в инсте посмотрел но не понял как они обновляют
    // при реализации такой как сейчас в addPost() у меня указано обновлять массив с постами но это не работает)
    
    
    // основной вопрос как прокинуть этот метод передачи через сервис ну и сделать так чтоб все работало корректно, как создать и использовать кэш, что нужно сделать чтоб это было реализовано грамотно
    // так же можешь плз посмотреть, этот файл и ServiceLocator, насколько грамотно я поделил все по функциям и правильно ли реализовал то что ты мне давал на прошлом занятии

//MARK: -
    //отлельный вопрос: если нажмешь на название опенкола и попадешь на его страницу, то там есть ссылка на инстаграм вот она работает не корректно, так как выводит в консоль кучу текста, сама функция separatedStringsArray полностью отрабатывает мою идею но я боюсь что там где-то бесконечный запрос или что-то в этом роде
    
    
    // квадра суперсложный вопрос как прокидывать данные в это таббар меню которое я копирнул с обучалки, там вроде пишется апдейтинг и указано что срабатывает при вызове но вызывать там другие функции кроме принта не выходит
    
