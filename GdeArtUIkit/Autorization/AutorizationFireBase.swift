//
//  AutorizationFireBase.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 05.12.2021.
//

import Foundation
import FirebaseAuth
import Firebase
import GoogleSignIn
import UIKit


protocol Autorization {
    func autorizationWithGoogle(loginController: UIViewController)
    func autorizationWithEmail(loginController: UIViewController, email: String?, password: String?)
}
class AutorizationFireBase: Autorization {
    
    func autorizationWithEmail(loginController: UIViewController, email: String?, password: String?) {
        guard let email = email else {return}
        guard let password = password else {return}
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard self != nil else { return }
            if let error = error {
                print("Error with Login", error)
                return
            }
            print("Succesfull Login", authResult?.user.uid ?? "")
            loginController.dismiss(animated: false)
        }
    }
    
    func autorizationWithGoogle(loginController: UIViewController) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: config, presenting: loginController) {  user, error in
            
            if let error = error {
              print(error)
              return
            }

            guard
              let authentication = user?.authentication,
              let idToken = authentication.idToken
            else {
              return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)

            Auth.auth().signIn(with: credential) { authResult, error in
                guard error == nil else { return }
                guard let user = authResult?.user else { return }
                    let uid : String = user.uid
                    let givenName : String = user.displayName ?? ""
                   // let familyName : String = profiledata.familyName ?? ""
                    let email : String = user.email ?? ""
                 //   let userName = "\(givenName) \(familyName)"
                
                
                        let dictionaryValues = ["email" : email, "userName" : givenName]
                        let values = [ uid : dictionaryValues]
                        Database.database().reference().child("users").updateChildValues(values) { (err, ref) in
                            if let err = err {
                                print("error to safe user info in database", err)
                                return
                            }
                            print(uid)
                            print(givenName)
                            print(email)
                            print("successfuly save user")
                            loginController.dismiss(animated: false)
                    }
                }
    }
}
}
