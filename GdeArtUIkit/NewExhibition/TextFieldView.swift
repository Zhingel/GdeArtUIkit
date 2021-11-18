//
//  textFieldView.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 17.11.2021.
//

import Foundation
import UIKit
class TextFieldView: UIView, UITextFieldDelegate {
    let exhibitionNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    let exhibitionNameTextField: UITextField = {
        let tf = UITextField()
        return tf
    }()
    let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 50.0)
        exhibitionNameTextField.delegate = self
        self.addSubview(exhibitionNameLabel)
        exhibitionNameLabel.constraints(top: topAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, paddingTop: 10, paddingBottom: 0, paddingleft: 15, paddingRight: 15, width: 0, height: 0)
        self.addSubview(exhibitionNameTextField)
        exhibitionNameTextField.constraints(top: exhibitionNameLabel.bottomAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, paddingTop: 5, paddingBottom: 0, paddingleft: 15, paddingRight: 15, width: 0, height: 0)
        self.addSubview(borderView)
        borderView.constraints(top: exhibitionNameTextField.bottomAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingBottom: 0, paddingleft: 15, paddingRight: -15, width: 0, height: 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
