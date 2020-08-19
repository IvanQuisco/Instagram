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
            
        self.delegate = self
        self.tabBar.tintColor = .black
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        setupControllers()
    }
    
    fileprivate func setupControllers() {
        let homeController = getNavController(rootController: HomeViewController(), selectedImageName: "home_selected", unselectedImageName: "home_unselected")
        
        let searchControllerr = getNavController(selectedImageName: "search_selected", unselectedImageName: "search_unselected")
        
        let plusController = getNavController(selectedImageName: "plus_unselected", unselectedImageName: "plus_unselected")
        
        let likeController = getNavController(selectedImageName: "like_selected", unselectedImageName: "like_unselected")
        
        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        let userController = getNavController(rootController: userProfileController, selectedImageName: "profile_selected", unselectedImageName: "profile_unselected")
        
        self.viewControllers = [homeController,searchControllerr,plusController,likeController,userController]
        
        
        guard let items = self.tabBar.items else { return }
        
        for item in items { item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0) }
        
    }
    
    
    func getNavController(rootController: UIViewController = UIViewController(), selectedImageName: String, unselectedImageName: String) -> UIViewController  {
        let navController = UINavigationController(rootViewController: rootController)
        navController.tabBarItem.image = UIImage(named: unselectedImageName)?.withRenderingMode(.alwaysOriginal)
        navController.tabBarItem.selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal)
        return navController
        
    }
}


extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = tabBarController.viewControllers?.firstIndex(of: viewController)
        if index == 2 {
            let layout = UICollectionViewFlowLayout()
            let photoController = PhotoSelectionController(collectionViewLayout: layout)
            let nav = UINavigationController(rootViewController: photoController)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
            return false
        }
        return true
    }
}
