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
                                Text("Дедлайн: \(task.post.deadLine)")
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
            HStack {
                NavigationLink {
                    CommentsView(task: task)
                        .navigationTitle(task.post.openCallName)
                } label: {
                    Image("comment")
                }

                Spacer()
                Button {
                    //
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.black)
                        .opacity(0.7)
                }
                Button {
                    //
                } label: {
                    Image("ribbon")
                }
            }
            .padding(.horizontal)
            .font(.title2)
        }
        .padding(.vertical, 10)
     }
 }

