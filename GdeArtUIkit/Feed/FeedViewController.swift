//
//  FeedViewController.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 19.11.2021.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase

class FeedViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Где Выставка"
        collectionView.register(OpenCallViewCell.self, forCellWithReuseIdentifier: "Cell")
        fetchData()
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        posts.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! OpenCallViewCell
        cell.post = posts[indexPath.item]
        cell.layer.cornerRadius = 35
        cell.layer.borderWidth = 0.3
        cell.layer.borderColor = UIColor.lightGray.cgColor
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.bounds.width - 30, height: view.bounds.width - 30)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
    }
    func fetchData() {
        let ref = Database.database().reference()
        ref.child("posts").observeSingleEvent(of: .value) { snapshot in
            guard let dictionaries = snapshot.value as? [String: Any] else {return}
            dictionaries.forEach { key, value in
                guard let dictionary = value as? [String: Any] else {return}
                let post = Post(dictionary: dictionary)
                self.posts.append(post)
            }
            print(self.posts)
            self.collectionView.reloadData()
        }
    }
}

