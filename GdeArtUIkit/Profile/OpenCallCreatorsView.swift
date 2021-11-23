//
//  OpenCallCreatorsView.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 23.11.2021.
//

import SwiftUI

struct OpenCallCreatorsView: View {
    @State var task : Task
    var body: some View {
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .foregroundColor(.white)
                .border(.black)
            
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
                    .onTapGesture {
                        task.showText.toggle()
                    }
                Image("1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .padding()
            
        }
        .padding()
    }
}

struct OpenCallCreatorsView_Previews: PreviewProvider {
    static var previews: some View {
        OpenCallCreatorsView(task: Task(id: "fff", post: Post(dictionary: ["description": "«Дата» – это однодневные выставки для произведений, которые еще нигде не выставлялись. Это может быть совсем новое произведение, которое нужно проверить на публике, или старая работа, для которой пока не нашлось подходящего опен колла. Концепция каждой «Дата» определяется по результатам сбора заявок." , "instagram": "Ezhingel", "openCall": "Дата 7", "curators": "Катюша", "userUid": "Giw8K9Ch0ycXKe3m4Oq5jBTe1yj1"]), showText: false))

    }
}
