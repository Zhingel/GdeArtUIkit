//
//  CommentsView.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 20.11.2021.
//

import SwiftUI

struct CommentsView: View {
    @State var text: String = ""
    var service = ServiceLocator().fetchData()
    @StateObject var model = FirebaseDataNew()
    @State var task : Task
    var body: some View {
        VStack {
            HeaderComments(task: task)
            Divider()
            ForEach(model.comments, id:\.commentId) {comment in
                HStack {
                    Image("1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 55, height: 55)
                    Text("userName ")
                        .bold()
                        .font(Font.system(size: 14))
                    + Text(comment.text)
                        .font(Font.system(size: 14))
                    Spacer()
                }
                .padding(.leading)
            }
            Spacer()
            VStack {
                Divider()
                HStack {
                    Image("1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 55, height: 55)
                    TextField("write your message", text: $text)
                        .textFieldStyle(.roundedBorder)
                        .padding(.trailing)
                    Button {
                        model.addCommentFunc(commentTextDelegate: text, postId: task.post.uid)
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerSize: CGSize(width: 30, height: 20))
                                .foregroundColor(.blue)
                                .frame(width: 50, height: 30)
                            Text("Send")
                                .foregroundColor(.white)
                            }
                    }
                    .padding(.trailing)

                }
            }
        }
        .onAppear {
            //MARK: - ??
            service.fetchComments(postId: task.post.uid)   //// ???/
        }
        .padding(.vertical, 7)
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView(task: Task(id: "fff", post: Post(dictionary: ["description": "«Дата» – это однодневные выставки для произведений, которые еще нигде не выставлялись. Это может быть совсем новое произведение, которое нужно проверить на публике, или старая работа, для которой пока не нашлось подходящего опен колла. Концепция каждой «Дата» определяется по результатам сбора заявок." , "instagram": "Ezhingel", "openCall": "Дата 7", "curators": "Катюша", "userUid": "Giw8K9Ch0ycXKe3m4Oq5jBTe1yj1"]), showText: false))
    }
}

struct HeaderComments: View {
    @State var task : Task
    var body: some View {
        HStack(alignment: .top) {
            Image("1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .frame(width: 60, height: 60)
            Text("\(task.post.openCallName) ")
                .bold()
                .font(Font.system(size: 14))
            + Text(task.post.description)
                .font(Font.system(size: 14))
            Spacer()
        }
    }
}
