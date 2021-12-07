//
//  SwiftUIView.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 19.11.2021.
//

import SwiftUI

struct SwiftUIView: View {
    @State var showText = false
    @ObservedObject var model = art()
    @StateObject var haha = FirebaseDataNew()
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(haha.tasks) { task in
                 taskCard(task: task)
                    .environmentObject(haha)
            }
        }
        .onAppear(perform: {
            if haha.tasks.isEmpty {
                self.haha.fetchPostsData()
            }
        })
//        .environmentObject(haha)
//        .onReceive(NotificationCenter.default.publisher(for: NSNotification.newPost)) { _ in
//            self.model.fetchData()
//            self.haha.fetchPostsData()
//        }
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIView()
//    }
//}
