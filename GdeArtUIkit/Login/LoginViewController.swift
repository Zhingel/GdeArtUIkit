//
//  LoginViewController.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 14.11.2021.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class LoginViewController: UIViewController {
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(loginUser), for: .touchUpInside)
        button.backgroundColor = .blue
        return button
    }()
    let userName: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Username"
        return textField
    }()
    let password: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Password"
        textField.isSecureTextEntry = true
        return textField
    }()
    let goToSignUp: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("go to SignUp", for: .normal)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupStackView()
    }
   
    
    func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: [userName, password, button])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        view.addSubview(stackView)
        stackView.constraints(top: view.topAnchor, bottom: nil, left: nil, right: nil, paddingTop: 300, paddingBottom: 0, paddingleft: 0, paddingRight: 0, width: 250, height: 150)
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.addSubview(goToSignUp)
        goToSignUp.constraints(top: nil, bottom: view.bottomAnchor, left: nil, right: nil, paddingTop: 0, paddingBottom: 20, paddingleft: 0, paddingRight: 0, width: 0, height: 0)
        goToSignUp.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    @objc func loginUser() {
        guard let email = userName.text else {return}
        guard let password = password.text else {return}
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            if let error = error {
                print("Error with Login", error)
                return
            }
            print("Succesfull Login", authResult?.user.uid)
        }
    }
    @objc func handleSignUp() {
        let signUpViewController = SignUpViewController()
        signUpViewController.modalPresentationStyle = .fullScreen
        present(signUpViewController, animated: false)
    }
}
