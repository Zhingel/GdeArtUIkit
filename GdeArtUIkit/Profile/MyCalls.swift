//
//  MyCalls.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 08.12.2021.
//

import SwiftUI

struct MyCalls: View {
    var userUid: String
    var tasks: [Task]
    @ObservedObject var model = FirebaseDataNew()
    var body: some View {
        ScrollView(showsIndicators: false) {
            ForEach (model.tasks) { task in
                if task.post.userUid == userUid {
                    OpenCallCreatorsView(task: task)
                }
            }
            
        }
//        .onAppear(perform: {
////                    if model.tasks.isEmpty {
//                        self.model.fetchPostsData()
////                    }
//                })
       
    }
}


