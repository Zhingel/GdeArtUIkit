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
    @ObservedObject var model = FirebaseDataNew()
   // @EnvironmentObject var haha: FirebaseDataNew
    var loginMenuHandler: (() -> Void)?
    var body: some View {
        UpperTabBar(userUid: user?.uid ?? "", tasks: model.tasks)
//            .onAppear(perform: {
////                        if model.tasks.isEmpty {
//                            self.model.fetchPostsData()
////                        }
//                    })
    //            .onReceive(NotificationCenter.default.publisher(for: NSNotification.newPost)) { _ in
    //                self.model.fetchData()
    //            }
            
    }
}

struct ProfileSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSwiftUIView()
    }
}
