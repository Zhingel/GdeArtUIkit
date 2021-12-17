//
//  OpenCallProfileViewModel.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 17.12.2021.
//

import Foundation
import SwiftUI

class OpenCallProfileViewModel: ObservableObject {
    @Published var task: Task?
    
    init() {
      print("Start")
    }
    
    
    func separatedStringsArray(instagram: String) -> [String] {
        print("stars")
        let username = instagram.replacingOccurrences(of: "@", with: "")
        let name = username.deletingPrefix("https://www.instagram.com/").deletingPrefix("https://instagram.com/").deletingPrefix("www.instagram.com/").deletingPrefix("instagram.com/").deletingPrefix("http://www.instagram.com/")
            let instagramNames: String = name
            print("llllllll    ", instagramNames)
            print("ddddddd     ", name)
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
