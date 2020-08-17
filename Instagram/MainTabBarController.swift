//
//  MainTabBarController.swift
//  Instagram
//
//  Created by Ivan Quintana on 05/08/20.
//  Copyright © 2020 Ivan Quintana. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupControllers()
    }
    
    fileprivate func setupControllers() {
        self.tabBar.tintColor = .black
        
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let loginController = LogInController()
                let nav = UINavigationController(rootViewController: loginController)
                nav.modalPresentationStyle = .fullScreen
                nav.isNavigationBarHidden = true
                self.present(nav, animated: true, completion: nil)
            }
            return
        }
        
        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        let userNav = UINavigationController(rootViewController: userProfileController)
        userNav.tabBarItem.image = UIImage(named: "profile_unselected")?.withRenderingMode(.alwaysOriginal)
        userNav.tabBarItem.selectedImage = UIImage(named: "profile_selected")?.withRenderingMode(.alwaysOriginal)
        self.viewControllers = [userNav]
        
    }
}
