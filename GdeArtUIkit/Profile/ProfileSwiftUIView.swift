//
//  ProfileSwiftUIView.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 20.11.2021.
//

import SwiftUI
import UIKit
import FirebaseAuth

struct ProfileSwiftUIView: View {
    let user = Auth.auth().currentUser
    @State var changeFoto = false
    @ObservedObject var model = art()
    var loginMenuHandler: (() -> Void)?
    var body: some View {
        VStack {
//            HStack {
//                Button {
//                    changeFoto.toggle()
//                } label: {
//                    Image("avatar")
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 70, height: 70)
//                        .clipShape(Circle())
//                        .padding(5)
//                        .background(Color.white)
//                        .clipShape(Circle())
//                }
//                Spacer()
//                Button {
//                   loginMenuHandler?()
//                } label: {
//                    Text("Add Open Call")
//                        .padding(.vertical, 5)
//                        .padding(.horizontal)
//                        .background(
//                            Capsule()
//                                .stroke(lineWidth: 1.5)
//                        )
//                }
//            }
//            .padding([.leading, .trailing])
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
                    if task.post.userUid == Auth.auth().currentUser?.uid {
                        OpenCallCreatorsView(task: task)
                    }
                }
                
            }
            .onReceive(NotificationCenter.default.publisher(for: NSNotification.newPost)) { _ in
                self.model.fetchData()
            }
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
