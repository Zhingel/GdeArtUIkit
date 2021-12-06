//
//  SwiftUIFeedViewController.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 19.11.2021.
//

import UIKit
import SwiftUI

class SwiftUIFeedViewController: UIViewController {
    let contentView = UIHostingController(rootView: SwiftUIView())
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Где выставка"
        addChild(contentView)
        view.addSubview(contentView.view)
        contentView.view.constraints(top: view.topAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingleft: 0, paddingRight: 0, width: 0, height: 0)
    }
}
