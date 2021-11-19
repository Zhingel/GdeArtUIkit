//
//  OpenCallProfileView.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 19.11.2021.
//

import SwiftUI

struct pageView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
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
                                Text("Дэдлайн: 29.06.21")
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
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                                .background(
                                    Capsule()
                                        .stroke(lineWidth: 1.5)
                                )
                        })
                    }
                    .offset(y: 70)
                    VStack(alignment: .leading, spacing: 10){
                       HStack {
                            Text("Placeholder")
                        Spacer()
                        }
                       .padding()
                        HStack {
                             Text("Placeholder")
                         Spacer()
                         }
                        .padding()
                        HStack {
                             Text("Placeholder")
                         Spacer()
                         }
                        .padding()
                         HStack {
                              Text("Placeholder")
                          Spacer()
                          }
                         .padding()
                        HStack {
                             Text("Placeholder")
                         Spacer()
                         }
                        .padding()
                         HStack {
                              Text("Placeholder")
                          Spacer()
                          }
                         .padding()
                        HStack {
                            Text("Placeholder")
                        Spacer()
                        }
                       .padding(40)
                        HStack {
                             Text("Placeholder")
                         Spacer()
                         }
                        .padding(40)
                        HStack {
                             Text("Placeholder")
                         Spacer()
                         }
                        .padding(40)
                         HStack {
                              Text("Placeholder")
                          Spacer()
                          }
                         .padding(40)
                         .padding(.vertical, 80)
                        
                    }
                    .offset(y: 80)
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
