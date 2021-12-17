//
//  OpenCallProfileView.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 19.11.2021.
//

import SwiftUI

struct PageView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var model = FeedViewModel()
    @StateObject var viewModel = OpenCallProfileViewModel()
    @State var task : Task
    @State var offSet: CGFloat = 0
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                GeometryReader { proxy -> AnyView in
                    let minY = proxy.frame(in: .global).minY
                    DispatchQueue.main.async {
                        self.offSet = minY
                    }
                    return AnyView(ZStack{
                        Image("3")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: getRect().width, height: minY > 0 ? 280 + minY : 280)
                        BlurView()
                            .opacity(blurViewOpacity())

                        VStack {
                            HStack {
                                Button(action: {
                                    self.presentationMode.wrappedValue.dismiss()
                                }, label: {
                                    Image(systemName: "chevron.backward")
                                    Text("Back")
                                })
                                Spacer()
                            }
                            Spacer()
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.top, 40)
                        .padding()
                        ZStack {
                            HStack {
                                Button(action: {
                                    self.presentationMode.wrappedValue.dismiss()
                                }, label: {
                                    Image(systemName: "chevron.backward")
                                    Text("Back")
                                })
                                Spacer()
                                Button(action: {
                                   
                                }, label: {
                                    Text("Edit")
                                })
                            }
                            VStack(spacing: 5) {
                                Text(task.post.openCallName)
                                    .fontWeight(.bold)
                                Text("Дедлайн: \(task.post.deadLine)")
                            }
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .offset(y: 100)
                        .opacity(blurViewOpacity())
                    }
                    .offset(y: minY > 0 ? -minY : -minY < 170 ? 0 : -minY - 170)
                    )
                    
                }
                .frame(height: 190)
                .zIndex(1)
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
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("Edit Profile")
                                .padding(.vertical, 5)
                                .padding(.horizontal)
                                .background(
                                    Capsule()
                                        .stroke(lineWidth: 1.5)
                                )
                        })
                    }
                    .offset(y: 70)
                    VStack(alignment: .leading, spacing: 10){
                        VStack(alignment: .leading) {
                            Text(task.post.openCallName)
                                .font(.system(size: 16, weight: .bold, design: .default))
                            Text("Дедлайн: \(task.post.deadLine)")
                                .font(.system(size: 12, weight: .semibold, design: .default))
                        }
                        .offset(x: -20, y: 10)
                        Spacer()
                        
                
                        
                    }
                    HStack {
                        VStack(alignment: .leading, spacing: 3) {
                            if task.post.curatorsName != nil && task.post.curatorsName != ""{
                                Text("Кураторы выставки:")
                                    .font(.system(size: 16, weight: .semibold, design: .default))
                                Text(task.post.curatorsName ?? "")
                                    .font(.system(size: 16, weight: .regular, design: .default))
                            }
                            if task.post.instagrammLink != nil && task.post.instagrammLink != ""{
                                Text("Контакты:")
                                    .font(.system(size: 16, weight: .semibold, design: .default))
                                HStack {
                                    Image("insta")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 15, height: 15)
//                                    ForEach(model.separatedStringsArray(instagram: task.post.instagrammLink ?? ""), id: \.self) { name in
//                                        if name != "" {
//                                            Button {
//                                                model.handleInstagram(instagram: name)
//                                            } label: {
//                                                Text(name)
//                                                    .font(.system(size: 16, weight: .regular, design: .default))
//                                            }
//                                        }
//                                    }
                                    
                                }

                            }
                            Text("Описание:")
                                .padding(.top, 10)
                                .font(.system(size: 16, weight: .semibold, design: .default))
                            Text(task.post.description)
                                
                        }
                        .padding(.top, 40)
                        Spacer()
                    }
                    
                }
                .padding(.horizontal)
                .zIndex(-offSet > 170 ? 0 : 1)
            }
        }
        .navigationBarHidden(true)
        .ignoresSafeArea(.all, edges: .top)
    }
    func blurViewOpacity() -> Double {
        let progress = -(offSet + 100) / 100
        return Double(-offSet > 10 ? progress : 0)
    }
}




extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}



struct BlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterialDark))
        return view
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}
