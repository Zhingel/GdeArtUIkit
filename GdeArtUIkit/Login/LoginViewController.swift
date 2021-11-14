//
//  LoginViewController.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 14.11.2021.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .green
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(button)
        button.constraints(top: view.topAnchor, bottom: nil, left: view.leftAnchor, right: nil, paddingTop: 100, paddingBottom: 0, paddingleft: 100, paddingRight: 0, width: 80, height: 50)
    }
}
