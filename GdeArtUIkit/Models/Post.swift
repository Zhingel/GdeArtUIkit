//
//  Post.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 18.11.2021.
//

import Foundation
struct Post {
    let uid: String
    let userUid: String
    let openCallName: String
    var curatorsName: String?
    var instagrammLink: String?
    let description: String
    let creationDate: Date
    let deadLine: String
    init(dictionary: [String : Any]) {
        self.userUid = dictionary["userUid"] as? String ?? ""
        self.openCallName = dictionary["openCall"] as? String ?? ""
        self.curatorsName = dictionary["curators"] as? String ?? ""
        self.instagrammLink = dictionary["instagram"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        let secondsFrom1970 = dictionary["creationDate"] as? Double ?? 0
        self.creationDate = Date(timeIntervalSince1970: secondsFrom1970)
        self.deadLine = dictionary["deadLine"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
//        let secondsFrom1970 = dictionary["creationDate"] as? Double ?? 0
//        self.creationDate = Date(timeIntervalSince1970: secondsFrom1970)
    }
}

struct Task: Identifiable {
    var id: String
    var post: Post
    var showText: Bool = false
    var savedCall: Bool = false
}
