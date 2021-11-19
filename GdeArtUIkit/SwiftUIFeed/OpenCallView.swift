//
//  OpenCallView.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 19.11.2021.
//

import SwiftUI
struct taskCard: View {
    @State var task : Task
     var body: some View {
        VStack {
            VStack(alignment: .leading) {
                NavigationLink(
                    destination: pageView(task: task),
                    label: {
                        HStack {
                            Image("1")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                                .frame(width: 70, height: 70)
                            VStack(alignment: .leading) {
                                Text(task.post.openCallName)
                                    .fontWeight(.semibold)
                                Text("Place: Moscow")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                                Text("Deadline: 29.09.2021")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }

                    })
                Text(task.post.description)
                    .font(.system(size: 14))
                    .lineLimit(task.showText ? nil : 4)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 7)
            }
            .onTapGesture {
                task.showText.toggle()
            }
            Image("1")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .padding(.vertical, 10)
     }
 }

