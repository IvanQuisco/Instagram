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
    
    let headerID = "headerID"
    
    var user: User? {
        didSet {
            DispatchQueue.main.async {
                self.navigationItem.title = self.user?.username
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .green
        setupCollectionView()
        fetchUser()
        
    }
    
    fileprivate func setupCollectionView() {
        collectionView.register(UserProfileHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
    }
    
    fileprivate func fetchUser() {
        guard let userID = Auth.auth().currentUser?.uid else {return}
        Database.database().reference().child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            self.user = User(dictionary: dictionary)
        }) { (error) in
            print("Failed to fetch user: ", error)
        }
    }
}

extension UserProfileController {
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! UserProfileHeaderView
        header.user = self.user
        return header
    }
    
}

extension UserProfileController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 200)
    }
    
}
