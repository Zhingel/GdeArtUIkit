//
//  NewExhibitionViewController.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 17.11.2021.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class NewExhibitionViewController: UIViewController {
    var post: Post?
    let exhibitionNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Название выставки(Open-call):"
        return label
    }()
    let exhibitionNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "enter..."
        return tf
    }()
    let borderView: UIView = {
        let view = UIView()
        view.tintColor = .black
        view.backgroundColor = .black
        return view
    }()
    let openCallNameTextField: TextFieldView = {
        let tf = TextFieldView()
        tf.exhibitionNameLabel.text = "Название выставки(Open-call):"
        tf.exhibitionNameTextField.placeholder = "enter Name"
        return tf
    }()
    let curatorNameTextField: TextFieldView = {
        let tf = TextFieldView()
        tf.exhibitionNameLabel.text = "Имена кураторов:"
        tf.exhibitionNameTextField.placeholder = "enter Name"
        return tf
    }()
    let InstagramProfileTextField: TextFieldView = {
        let tf = TextFieldView()
        tf.exhibitionNameLabel.text = "Instagram Profile:"
        tf.exhibitionNameTextField.placeholder = "enter Name"
        return tf
    }()
    let captionsTextField: TextFieldView = {
        let tf = TextFieldView()
        tf.exhibitionNameLabel.text = "Описание выставки"
        tf.exhibitionNameTextField.placeholder = "enter Name"
        return tf
    }()
    let saveOpenCallButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("save Open Call", for: .normal)
        button.backgroundColor = .blue
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleSaveopenCall), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Добавить Open-Call"
        setupStackViews()
    }
    
    fileprivate func setupStackViews() {
        view.addSubview(openCallNameTextField)
        openCallNameTextField.constraints(top: view.topAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 60, paddingBottom: 0, paddingleft: 15, paddingRight: 15, width: 0, height: 50)
        view.addSubview(curatorNameTextField)
        curatorNameTextField.constraints(top: openCallNameTextField.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingBottom: 0, paddingleft: 15, paddingRight: 15, width: 0, height: 50)
        view.addSubview(InstagramProfileTextField)
        InstagramProfileTextField.constraints(top: curatorNameTextField.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingBottom: 0, paddingleft: 15, paddingRight: 15, width: 0, height: 50)
        view.addSubview(saveOpenCallButton)
        saveOpenCallButton.constraints(top: nil, bottom: view.bottomAnchor, left: nil, right: nil, paddingTop: 0, paddingBottom: 25, paddingleft: 0, paddingRight: 0, width: 150, height: 40)
        saveOpenCallButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    @objc func handleSaveopenCall() {
        guard let curators = curatorNameTextField.exhibitionNameTextField.text else {return}
        guard let openCall = openCallNameTextField.exhibitionNameTextField.text else {return}
        guard let instagram = InstagramProfileTextField.exhibitionNameTextField.text else {return}
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let values = ["curators" : curators, "openCall" : openCall, "instagram" : instagram]
        Database.database().reference().child("posts").child(uid).childByAutoId().updateChildValues(values) { (err, ref) in
            if let err = err {
                print("Failed", err)
                return
            }
            print("Successfuly save to db")
            self.dismiss(animated: true)
        }
        
    }
}
