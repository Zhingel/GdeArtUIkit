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
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(model.tasks) { task in
                 taskCard(task: task)
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.newPost)) { _ in
            self.model.fetchData()
        }
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIView()
//    }
//}
