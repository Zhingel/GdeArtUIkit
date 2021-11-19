//
//  OpenCallViewCell.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 19.11.2021.
//

import Foundation
import UIKit
class OpenCallViewCell: UICollectionViewCell {
    let openCallNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Название"
        return label
    }()
    let curatorsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "имена кураторов"
        return label
    }()
    let instagramLabel: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Instagram", for: .normal)
        button.isHidden = true
        return button
    }()
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Описание опен - кола"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(openCallNameLabel)
        openCallNameLabel.constraints(top: topAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, paddingTop: 30, paddingBottom: 0, paddingleft: 30, paddingRight: -30, width: 0, height: 0)
        addSubview(curatorsLabel)
        addSubview(instagramLabel)
        instagramLabel.constraints(top: openCallNameLabel.bottomAnchor, bottom: nil, left: curatorsLabel.rightAnchor, right: rightAnchor, paddingTop: 10, paddingBottom: 0, paddingleft: 0, paddingRight: -30, width: 0, height: 0)
        curatorsLabel.constraints(top: openCallNameLabel.bottomAnchor, bottom: nil, left: leftAnchor, right: instagramLabel.leftAnchor, paddingTop: 10, paddingBottom: 0, paddingleft: 30, paddingRight: -10, width: 0, height: 0)
        addSubview(descriptionLabel)
        descriptionLabel.constraints(top: curatorsLabel.bottomAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, paddingTop: 15, paddingBottom: 15, paddingleft: 30, paddingRight: -30, width: 0, height: 0)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
