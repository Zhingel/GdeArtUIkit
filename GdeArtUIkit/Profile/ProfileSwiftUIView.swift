//
//  ProfileSwiftUIView.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 20.11.2021.
//

import SwiftUI
import UIKit


struct ProfileSwiftUIView: View {
    let user = AutorizationFireBase.auth.currentUser
    @State var changeFoto = false
    @ObservedObject var model = FirebaseDataNew()
    @EnvironmentObject var haha: FirebaseDataNew
    var loginMenuHandler: (() -> Void)?
    var body: some View {
        VStack {
            Divider()
            HStack(spacing: 40) {
                Button {
                    //
                } label: {
                    Image("gear")
                }
                Divider().frame(width: 0.5, height: 20)
                Button {
                    //
                } label: {
                    Image("gear")
                }
                Divider().frame(width: 0.5, height: 20)
                Button {
                    //
                } label: {
                    Image("ribbon")
                }

            }
            Divider()
            ScrollView(showsIndicators: false) {
                ForEach (model.tasks) { task in
                    if task.post.userUid == user?.uid {
                        OpenCallCreatorsView(task: task)
                    }
                }
                
            }
            .onAppear(perform: {
                if model.tasks.isEmpty {
                    self.model.fetchPostsData()
                }
            })
//            .onReceive(NotificationCenter.default.publisher(for: NSNotification.newPost)) { _ in
//                self.model.fetchData()
//            }
        }
        .actionSheet(isPresented: $changeFoto) {
            ActionSheet(title: Text("Сменить фото"), buttons: [
                .default(Text("Открыть галлерею")) { print("fgfgdfd")},
                .cancel()
            ])
        }

    }
}

struct ProfileSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSwiftUIView()
    }
}
