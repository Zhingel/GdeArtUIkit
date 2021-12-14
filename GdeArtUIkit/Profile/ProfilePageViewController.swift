//
//  ViewController.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 14.11.2021.
//

import UIKit
import SwiftUI

class ProfilePageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
//    lazy var contentView: UIHostingController<ProfileSwiftUIView> = {
//        var view = ProfileSwiftUIView()
//        view.loginMenuHandler = { [weak self] in
//            self?.handleAdd()
//        }
//        let vc = UIHostingController(rootView: view)
//        return vc
//    }()
    let service = ServiceLocator().fetchData()
    var user: User?
    let contentView = UIHostingController(rootView: ProfileSwiftUIView())
    let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(handlePlusPhoto), for: .touchUpInside)
        button.layer.cornerRadius = button.frame.width/2
        button.layer.masksToBounds = true
        return button
    }()
    let addOpenCallButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Open Call", for: .normal)
        button.layer.borderWidth = 1.6
        button.layer.borderColor = UIColor(.blue).cgColor
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let user = AutorizationFireBase.auth.currentUser else {return}
        print("KKKKKKKKK", user.uid)
        navigationItem.title = user.displayName
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "gear")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(logOutMethod))
        addChild(contentView)
        let hadderView = UIView()
        hadderView.backgroundColor = .white
        hadderView.addSubview(plusPhotoButton)
        plusPhotoButton.constraints(top: hadderView.topAnchor, bottom: nil, left: hadderView.leftAnchor, right: nil, paddingTop: 100, paddingBottom: 0, paddingleft: 22, paddingRight: 0, width: 70, height: 70)
        hadderView.addSubview(addOpenCallButton)
        addOpenCallButton.constraints(top: hadderView.topAnchor, bottom: nil, left: nil, right: hadderView.rightAnchor, paddingTop: 120, paddingBottom: 0, paddingleft: 0, paddingRight: -12, width: 150, height: 32)
        view.addSubview(hadderView)
        hadderView.constraints(top: view.topAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingleft: 0, paddingRight: 0, width: 0, height: 180)
        view.addSubview(contentView.view)
        contentView.view.constraints(top: hadderView.bottomAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingleft: 0, paddingRight: 0, width: 0, height: 0)
        service.fetchUserWithUID(uid: user.uid) { user in
            self.service.fetchImageWithURL(urlString: user.profileImage) { photoImage in
                self.plusPhotoButton.setImage(photoImage.withRenderingMode(.alwaysOriginal), for: .normal)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {

        if AutorizationFireBase.auth.currentUser == nil {
                let loginViewController = LoginViewController()
                let navController = UINavigationController(rootViewController: loginViewController)
                navController.modalPresentationStyle = .currentContext
                navController.navigationBar.scrollEdgeAppearance = navController.navigationBar.standardAppearance
                self.present(navController, animated: true)
            }
    }

    
        @objc func handleAdd() {
        let viewController = NewExhibitionViewController()
        let navViewController = UINavigationController(rootViewController: viewController)
        navViewController.navigationBar.scrollEdgeAppearance = navViewController.navigationBar.standardAppearance
        present(navViewController, animated: true)
    }
    @objc func logOutMethod() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: {_ in
            do {
                try AutorizationFireBase.auth.signOut()
                let loginController = LoginViewController()
                let navController = UINavigationController(rootViewController: loginController)
                navController.modalPresentationStyle = .currentContext
                self.present(navController, animated: true)
            } catch {
                print("Some problem with LogOut")
            }
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true)
    }
    @objc func handlePlusPhoto() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Сменить фото", style: .default, handler: {_ in
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.allowsEditing = true
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            plusPhotoButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        else if let originalImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage {
            plusPhotoButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        guard let user = AutorizationFireBase.auth.currentUser else {return}
        guard let image = self.plusPhotoButton.imageView?.image else {return}
        service.uploadImageToFireStore(uid: user.uid, image: image)
        dismiss(animated: true, completion: nil)
    }
}

