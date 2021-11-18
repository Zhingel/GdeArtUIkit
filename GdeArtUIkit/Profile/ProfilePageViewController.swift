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
        button.setTitle("LogOut", for: .normal)
        //button.tintColor = .white
        button.addTarget(self, action: #selector(logOutUser), for: .touchUpInside)
       // button.backgroundColor = .blue
        return button
    }()
    let instagramButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Instagram", for: .normal)
        button.addTarget(self, action: #selector(handleInstagram), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let user = Auth.auth().currentUser else {return}
        navigationItem.title = user.displayName
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        view.addSubview(instagramButton)
        instagramButton.constraints(top: button.bottomAnchor, bottom: nil, left: nil, right: nil, paddingTop: 15, paddingBottom: 0, paddingleft: 0, paddingRight: 0, width: 0, height: 0)
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
//    override func viewWillDisappear(_ animated: Bool) {
//        dismiss(animated: true)
//    }
    
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
        print(Auth.auth().currentUser?.uid)
    }
    @objc func handleAdd() {
        let viewController = NewExhibitionViewController()
        let navViewController = UINavigationController(rootViewController: viewController)
        navViewController.navigationBar.scrollEdgeAppearance = navViewController.navigationBar.standardAppearance
        present(navViewController, animated: true)
    }
    @objc func handleInstagram() {
        let Username =  "majidk" // Your Instagram Username here
            let appURL = URL(string: "instagram://user?username=\(Username)")!
            let application = UIApplication.shared

            if application.canOpenURL(appURL) {
                application.open(appURL)
            } else {
                // if Instagram app is not installed, open URL inside Safari
                let webURL = URL(string: "https://instagram.com/\(Username)")!
                application.open(webURL)
            }
    }
}

