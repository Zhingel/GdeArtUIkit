//
//  LoginViewController.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 14.11.2021.
//

import UIKit


class LoginViewController: UIViewController {
    let authorization = ServiceLocator().getAuthService()
//MARK: - setup Values
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(loginUser), for: .touchUpInside)
        button.backgroundColor = .blue
        return button
    }()
    let googleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Google", for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(googleLogin), for: .touchUpInside)
        button.backgroundColor = .blue
        return button
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
    let goToSignUp: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("go to SignUp", for: .normal)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
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
        let stackView = UIStackView(arrangedSubviews: [email, password, button, googleButton])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        view.addSubview(stackView)
        stackView.constraints(top: view.topAnchor, bottom: nil, left: nil, right: nil, paddingTop: 300, paddingBottom: 0, paddingleft: 0, paddingRight: 0, width: 250, height: 200)
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.addSubview(goToSignUp)
        goToSignUp.constraints(top: nil, bottom: view.bottomAnchor, left: nil, right: nil, paddingTop: 0, paddingBottom: 80, paddingleft: 0, paddingRight: 0, width: 0, height: 0)
        goToSignUp.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    //MARK: - Button handlers
    @objc func loginUser() {
        authorization.autorizationWithEmail(email: email.text, password: password.text) {
            self.dismiss(animated: false)
        }
    }
    @objc func handleSignUp() {
        let signUpViewController = SignUpViewController()
        navigationController?.pushViewController(signUpViewController, animated: false)
    }
    @objc func googleLogin() {
        authorization.autorizationWithGoogle(loginController: self)
    }
}

