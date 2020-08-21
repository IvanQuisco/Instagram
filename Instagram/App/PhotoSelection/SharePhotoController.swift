//
//  SharePhotoController.swift
//  Instagram
//
//  Created by Ivan Quintana on 21/08/20.
//  Copyright © 2020 Ivan Quintana. All rights reserved.
//

import UIKit

class SharePhotoController: UIViewController {
    
    var selectedView: UIImage? {
        didSet {
            DispatchQueue.main.async {
                self.imageView.image = self.selectedView
            }
        }
    }
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    let textView: UITextView = {
        let view = UITextView()
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUI()
    }
    
    fileprivate func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(shareButtonTapped))
    }
    
    fileprivate func setupUI() {
        self.view.backgroundColor = .white
        
        let contentView = UIView()
        view.addSubview(contentView)
        contentView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddings: .zero, width: 0, height: 100)
        
        contentView.addSubview(imageView)
        imageView.anchor(top: contentView.topAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: nil, paddings: .init(top: 8, left: 8, bottom: -8, right: 0), width: 84, height: 0)
        
        contentView.addSubview(textView)
        textView.anchor(top: contentView.topAnchor, bottom: contentView.bottomAnchor, leading: imageView.trailingAnchor, trailing: contentView.trailingAnchor, paddings: .init(top: 8, left: 4, bottom: -8, right: -4), width: 0, height: 0)
        
    }
}

extension SharePhotoController {
    @objc func shareButtonTapped() {
        print(123)
    }
}
