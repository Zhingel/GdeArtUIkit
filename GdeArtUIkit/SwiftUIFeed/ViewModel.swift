//
//  ViewModel.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 19.11.2021.
//

import Foundation
import FirebaseDatabase
import SwiftUI
class art: ObservableObject {
    @Published var tasks = [Task]()
    
    init() {
        fetchData()
    }
    
    ///разделить нарезку строки
    ///и
    ///переход в инсту на разные функции
    ///так как она сама себя выполняет
    ///я уже поделил вытащил массив
    ///а потом внутри себя же выдаю еще массив
    func separatedStringsArray(instagram: String) -> [String] {
        let username = instagram.replacingOccurrences(of: "@", with: "")
        var instagramNamesArray = [String]()
        let name = username.deletingPrefix("https://www.instagram.com/").deletingPrefix("https://instagram.com/").deletingPrefix("www.instagram.com/").deletingPrefix("instagram.com/").deletingPrefix("http://www.instagram.com/")
            let instagramNames: String = name
            let instagramArray = instagramNames.components(separatedBy: [" ", ","])
        for hashTagName in instagramArray {
            if hashTagName != "" {
                instagramNamesArray.append(hashTagName)
            }
        }
        return instagramArray
    }
    func handleInstagram(instagram: String) {
        let appURL = URL(string: "instagram://user?username=\(instagram)")!
        let application = UIApplication.shared
        if application.canOpenURL(appURL) {
            application.open(appURL)
        } else {
            // if Instagram app is not installed, open URL inside Safari
            let webURL = URL(string: "https://instagram.com/\(instagram)")!
            application.open(webURL)
            print(webURL)
        }
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



extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
}

