//
//  NewExhibitionViewController.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 17.11.2021.
//

import Foundation
import UIKit
class NewExhibitionViewController: UIViewController {
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
//        view.frame.size.width = view.bounds.width
//        view.frame.size.height = 1
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
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Добавить Open-Call"
        setupStackViews()
    }
    
    fileprivate func setupStackViews() {
        let stackView = UIStackView(arrangedSubviews: [openCallNameTextField, curatorNameTextField])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        view.addSubview(stackView)
        stackView.constraints(top: view.topAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 80, paddingBottom: 0, paddingleft: 30, paddingRight: -30, width: 0, height: 500)
        
    }
}
