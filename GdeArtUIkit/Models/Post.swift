//
//  Post.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 18.11.2021.
//

import Foundation
struct Post {
    let userUid: String
    let openCallName: String
    var curatorsName: String?
    var instagrammLink: String?
    let description: String
    init(dictionary: [String : Any]) {
        self.userUid = dictionary["userUid"] as? String ?? ""
        self.openCallName = dictionary["openCall"] as? String ?? ""
        self.curatorsName = dictionary["curators"] as? String ?? ""
        self.instagrammLink = dictionary["instagram"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        
//        let secondsFrom1970 = dictionary["creationDate"] as? Double ?? 0
//        self.creationDate = Date(timeIntervalSince1970: secondsFrom1970)
    }
}
