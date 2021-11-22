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
        view.backgroundColor = .lightGray
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
    let instagramProfileTextField: TextFieldView = {
        let tf = TextFieldView()
        tf.exhibitionNameLabel.text = "Instagram Profile:"
        tf.exhibitionNameTextField.placeholder = "@data.in.art"
        return tf
    }()
    let captionsTextField: TextFieldView = {
        let tf = TextFieldView()
        tf.exhibitionNameLabel.text = "Описание выставки"
        tf.exhibitionNameTextField.placeholder = "enter Name"
        return tf
    }()
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Описание:"
        return label
    }()
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.lightGray.cgColor
        return textView
    }()
    let saveOpenCallButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("save Open Call", for: .normal)
        button.backgroundColor = .blue
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleSaveopenCall), for: .touchUpInside)
        return button
    }()
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        return datePicker
    }()
    let datePickerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Дедлайн:"
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Добавить Open-Call"
        setupStackViews()
    }
    
    fileprivate func setupStackViews() {
        view.addSubview(openCallNameTextField)
        openCallNameTextField.constraints(top: view.topAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 60, paddingBottom: 0, paddingleft: 15, paddingRight: -15, width: 0, height: 50)
        view.addSubview(curatorNameTextField)
        curatorNameTextField.constraints(top: openCallNameTextField.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingBottom: 0, paddingleft: 15, paddingRight: -15, width: 0, height: 50)
        view.addSubview(instagramProfileTextField)
        instagramProfileTextField.constraints(top: curatorNameTextField.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingBottom: 0, paddingleft: 15, paddingRight: -15, width: 0, height: 50)
        view.addSubview(saveOpenCallButton)
        saveOpenCallButton.constraints(top: nil, bottom: view.bottomAnchor, left: nil, right: nil, paddingTop: 0, paddingBottom: 25, paddingleft: 0, paddingRight: 0, width: 150, height: 40)
        saveOpenCallButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.addSubview(datePickerLabel)
        datePickerLabel.constraints(top: instagramProfileTextField.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingBottom: 0, paddingleft: 30, paddingRight: -15, width: 0, height: 0)
        view.addSubview(datePicker)
        datePicker.constraints(top: instagramProfileTextField.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 8, paddingBottom: 0, paddingleft: 30, paddingRight: -45, width: 0, height: 0)
        view.addSubview(borderView)
        borderView.constraints(top: datePickerLabel.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingBottom: 0, paddingleft: 30, paddingRight: -30, width: 0, height: 0.5)
        view.addSubview(descriptionLabel)
        descriptionLabel.constraints(top: borderView.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingBottom: 0, paddingleft: 30, paddingRight: -15, width: 0, height: 0)
        view.addSubview(descriptionTextView)
        descriptionTextView.constraints(top: descriptionLabel.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 5, paddingBottom: 0, paddingleft: 30, paddingRight: -30, width: 0, height: 150)
    }
    @objc func handleSaveopenCall() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        let deadline = dateFormatter.string(from: datePicker.date)
        print(deadline)
        guard let curators = curatorNameTextField.exhibitionNameTextField.text else {return}
        guard let openCall = openCallNameTextField.exhibitionNameTextField.text else {return}
        guard let instagram = instagramProfileTextField.exhibitionNameTextField.text else {return}
        guard let description = descriptionTextView.text else {return}
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let values = ["curators" : curators, "openCall" : openCall, "instagram" : instagram, "description" : description, "userUid": uid, "creationDate" : Date().timeIntervalSince1970, "deadLine" : deadline] as [String : Any]
        Database.database().reference().child("posts").childByAutoId().updateChildValues(values) { (err, ref) in
            if let err = err {
                print("Failed", err)
                return
            }
            print("Successfuly save to db")
            NotificationCenter.default.post(name: NSNotification.newPost,
                                            object: nil,
                                            userInfo: nil)
            self.dismiss(animated: true)
        }
        
    }
}

extension NSNotification {
    static let newPost = Notification.Name.init("new_post")
}
