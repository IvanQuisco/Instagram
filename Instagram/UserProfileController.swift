//
//  UserProfileController.swift
//  Instagram
//
//  Created by Ivan Quintana on 05/08/20.
//  Copyright © 2020 Ivan Quintana. All rights reserved.
//

import UIKit
import Firebase

class UserProfileController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .green
        fetchUser()
    }
    
    fileprivate func fetchUser() {
        guard let userID = Auth.auth().currentUser?.uid else {return}
        Database.database().reference().child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            
            let username = dictionary["username"] as? String
            self.navigationItem.title = username
        }) { (error) in
            print("Failed to fetch user: ", error)
        }
    }
}
