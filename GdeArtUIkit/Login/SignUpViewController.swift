//
//  SignUpViewController.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 16.11.2021.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController {
//MARK: - setup Values
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SignUp", for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(createUser), for: .touchUpInside)
        button.backgroundColor = .blue
        return button
    }()
    let userName: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Username"
        return textField
    }()
    let email: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Email"
        return textField
    }()
    let password: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Password"
        textField.isSecureTextEntry = true
        return textField
    }()
    let passwordRepeat: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Password again"
        textField.isSecureTextEntry = true
        return textField
    }()
    let goToLogin: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("go to Login", for: .normal)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
//MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupStackView()
    }
//MARK: - setupViews
    func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: [email, userName, password, passwordRepeat, button])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        view.addSubview(stackView)
        stackView.constraints(top: view.topAnchor, bottom: nil, left: nil, right: nil, paddingTop: 300, paddingBottom: 0, paddingleft: 0, paddingRight: 0, width: 250, height: 200)
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.addSubview(goToLogin)
        goToLogin.constraints(top: nil, bottom: view.bottomAnchor, left: nil, right: nil, paddingTop: 0, paddingBottom: 20, paddingleft: 0, paddingRight: 0, width: 0, height: 0)
        goToLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
//MARK: - Button's Handlers
    @objc func createUser() {
        guard let email = email.text else {return}
        guard let userName = userName.text else {return}
        guard let password = password.text else {return}
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Failed to create user", error)
                return
            }
            guard let uid = authResult?.user.uid else {return}
            let dictionaryValues = ["email" : email, "userName" : userName]
            let values = [ uid : dictionaryValues]
            Database.database().reference().child("users").updateChildValues(values) { (err, ref) in
                if let err = err {
                    print("error to safe user info in database", err)
                    return
                }
                print("successfuly save user")
            }
        }
    }
    @objc func handleLogin() {
        dismiss(animated: false)
    }
}
