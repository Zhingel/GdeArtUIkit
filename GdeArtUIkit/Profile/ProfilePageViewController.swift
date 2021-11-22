//
//  ViewController.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 14.11.2021.
//

import UIKit
import FirebaseAuth
import SwiftUI

class ProfilePageViewController: UIViewController {
    let contentView = UIHostingController(rootView: ProfileSwiftUIView())
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("LogOut", for: .normal)
        button.addTarget(self, action: #selector(logOutUser), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let user = Auth.auth().currentUser else {return}
        navigationItem.title = user.displayName
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
//        view.addSubview(button)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        addChild(contentView)
        view.addSubview(contentView.view)
        contentView.view.constraints(top: view.topAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingleft: 0, paddingRight: 0, width: 0, height: 0)
    }
    override func viewWillAppear(_ animated: Bool) {

            if Auth.auth().currentUser == nil {
                let loginViewController = LoginViewController()
                let navController = UINavigationController(rootViewController: loginViewController)
                navController.modalPresentationStyle = .currentContext
                navController.navigationBar.scrollEdgeAppearance = navController.navigationBar.standardAppearance
                self.present(navController, animated: true)
            }
        
    }

    
    @objc func logOutUser() {
        print("LogOut")
        do {
            try Auth.auth().signOut()
            let loginController = LoginViewController()
            let navController = UINavigationController(rootViewController: loginController)
            navController.modalPresentationStyle = .currentContext
            self.present(navController, animated: true)
        } catch {
            print("Some problem with LogOut")
        }
    }
    @objc func handleAdd() {
        let viewController = NewExhibitionViewController()
        let navViewController = UINavigationController(rootViewController: viewController)
        navViewController.navigationBar.scrollEdgeAppearance = navViewController.navigationBar.standardAppearance
        present(navViewController, animated: true)
    }
}

