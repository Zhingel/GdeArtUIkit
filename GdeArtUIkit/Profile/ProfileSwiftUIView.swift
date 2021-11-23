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
    @ObservedObject var model = art()
    var loginMenuHandler: (() -> Void)?
    var body: some View {
        VStack {
            HStack {
                Image("2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())
                    .padding(5)
                    .background(Color.white)
                    .clipShape(Circle())
                Spacer()
                Button {
                   loginMenuHandler?()
                } label: {
                    Text("Add Open Call")
                        .padding(.vertical, 5)
                        .padding(.horizontal)
                        .background(
                            Capsule()
                                .stroke(lineWidth: 1.5)
                        )
                }
            }
            .padding([.leading, .trailing])
            Divider()
            ScrollView {
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

    }
}

struct ProfileSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSwiftUIView()
    }
}
