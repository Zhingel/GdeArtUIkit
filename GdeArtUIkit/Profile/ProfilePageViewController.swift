//
//  ViewController.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 14.11.2021.
//

import UIKit
import FirebaseAuth

class ProfilePageViewController: UIViewController {
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        //button.tintColor = .white
        button.addTarget(self, action: #selector(loginUser), for: .touchUpInside)
       // button.backgroundColor = .blue
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    @objc func loginUser() {
        print("login")
        if Auth.auth().currentUser != nil {
            
        }
    }
}

