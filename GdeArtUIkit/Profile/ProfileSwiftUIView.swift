//
//  ProfileSwiftUIView.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 20.11.2021.
//

import SwiftUI
import UIKit

struct ProfileSwiftUIView: View {
    var loginMenuHandler: (() -> Void)?
    var body: some View {
        Button {
           loginMenuHandler?()
        } label: {
            Text("Log OUt")
        }

    }
}

struct ProfileSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSwiftUIView()
    }
}
