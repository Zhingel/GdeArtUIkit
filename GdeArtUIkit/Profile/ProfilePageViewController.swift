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
    lazy var contentView: UIHostingController<ProfileSwiftUIView> = {
        var view = ProfileSwiftUIView()
        view.loginMenuHandler = { [weak self] in
            self?.handleAdd()
        }
        let vc = UIHostingController(rootView: view)
        return vc
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let user = Auth.auth().currentUser else {return}
        navigationItem.title = user.displayName
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "gear")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(logOutMethod))
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

    
        @objc func handleAdd() {
        let viewController = NewExhibitionViewController()
        let navViewController = UINavigationController(rootViewController: viewController)
        navViewController.navigationBar.scrollEdgeAppearance = navViewController.navigationBar.standardAppearance
        present(navViewController, animated: true)
    }
    @objc func logOutMethod() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: {_ in
            do {
                try Auth.auth().signOut()
                let loginController = LoginViewController()
                let navController = UINavigationController(rootViewController: loginController)
                navController.modalPresentationStyle = .currentContext
                self.present(navController, animated: true)
            } catch {
                print("Some problem with LogOut")
            }
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true)
    }
}

