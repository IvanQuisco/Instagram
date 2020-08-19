//
//  PhotoSelectionController.swift
//  Instagram
//
//  Created by Ivan Quintana on 19/08/20.
//  Copyright © 2020 Ivan Quintana. All rights reserved.
//

import UIKit

class PhotoSelectionController: UICollectionViewController {
    
    let cellID = "cellID"
    let headerID = "headerID"
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .cyan
        setupNavigationBar()
    }
    
    fileprivate func setupNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .black
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonTapped))
    }
    
}

extension PhotoSelectionController {
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func nextButtonTapped() {
        print("Next")
    }
}
