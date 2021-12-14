//
//  Comment.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 09.12.2021.
//

import Foundation
struct Comment {
    let commentId: String
    let creationDate: Date
    let text: String
    let uid: String
    init(commentId: String, dictionary: [String: Any]) {
        self.commentId = commentId
        let secondsFrom1970 = dictionary["creationDate"] as? Double ?? 0
        self.creationDate = Date(timeIntervalSince1970: secondsFrom1970)
        self.text = dictionary["text"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
