//
//  ViewModel.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 19.11.2021.
//

import Foundation
import FirebaseDatabase
import SwiftUI
class FeedViewModel: ObservableObject {
    @Published var tasks = [Task]()
    @Published var comments = [Comment]()

    
    init() {
        let fetchingData = ServiceLocator().fetchData()
        fetchingData.fetchPostsData { task in
            self.tasks.append(task)
        }
     
    }
    
    func separatedStringsArray(instagram: String) -> [String] {
        let username = instagram.replacingOccurrences(of: "@", with: "")
        let name = username.deletingPrefix("https://www.instagram.com/").deletingPrefix("https://instagram.com/").deletingPrefix("www.instagram.com/").deletingPrefix("instagram.com/").deletingPrefix("http://www.instagram.com/")
            let instagramNames: String = name
            let instagramArray = instagramNames.components(separatedBy: [" ", ","])
        print(instagramArray) ////????
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
    
     
   
}






