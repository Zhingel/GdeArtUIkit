//
//  Post.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 18.11.2021.
//

import Foundation
struct Post {
    let user: User
    let openCallName: String
    var curatorsName: String?
    var instagrammLink: String?
    let description: String
    init(user: User, dictionary: [String : Any]) {
        self.user = user
        self.openCallName = dictionary["openCallName"] as? String ?? ""
        self.curatorsName = dictionary["curatorsName"] as? String ?? ""
        self.instagrammLink = dictionary["instagrammLink"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        
//        let secondsFrom1970 = dictionary["creationDate"] as? Double ?? 0
//        self.creationDate = Date(timeIntervalSince1970: secondsFrom1970)
    }
}
