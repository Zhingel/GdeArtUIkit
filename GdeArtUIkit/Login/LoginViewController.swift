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
import GoogleSignIn

class LoginViewController: UIViewController {
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
        guard let email = email.text else {return}
        guard let password = password.text else {return}
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard self != nil else { return }
            if let error = error {
                print("Error with Login", error)
                return
            }
            print("Succesfull Login", authResult?.user.uid ?? "")
        }
    }
    @objc func handleSignUp() {
        let signUpViewController = SignUpViewController()
        navigationController?.pushViewController(signUpViewController, animated: false)
    }
    @objc func googleLogin() {
        let locator = ServiceLocator()
        let googleAuthorization = locator.getAuthService()
        googleAuthorization.autorizationWithGoogle(loginController: self)
    }
}
















//{ user, error in
//    guard error == nil else { return }
//    guard let user = user else { return }
//    if let profiledata = user.profile {
//        let uid : String = user.userID ?? ""
//        let givenName : String = profiledata.givenName ?? ""
//        let familyName : String = profiledata.familyName ?? ""
//        let email : String = profiledata.email
//        let userName = "\(givenName) \(familyName)"
//
//
//        let dictionaryValues = ["email" : email, "userName" : userName]
//        let values = [ uid : dictionaryValues]
//        Database.database().reference().child("users").updateChildValues(values) { (err, ref) in
//            if let err = err {
//                print("error to safe user info in database", err)
//                return
//            }
//            print("successfuly save user")
//        }
//    }
//}
