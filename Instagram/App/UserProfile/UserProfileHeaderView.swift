//
//  UserProfileHeaderView.swift
//  Instagram
//
//  Created by Ivan Quintana on 16/08/20.
//  Copyright © 2020 Ivan Quintana. All rights reserved.
//

import Foundation
import UIKit

class UserProfileHeaderView: UICollectionReusableView {
    
    var user: User? {
        didSet {
            setUserInfo()
        }
    }
    
    
    let userProfileImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 40
        view.backgroundColor = .gray
        view.clipsToBounds = true
        return view
    }()
    
    
    let gridButton: UIButton = {
        let btn = UIButton(type: .system)
        let image = UIImage(named: "grid")
        btn.setImage(image, for: .normal)
        return btn
    }()
    
    let listButton: UIButton = {
        let btn = UIButton(type: .system)
        let image = UIImage(named: "list")
        btn.setImage(image, for: .normal)
        btn.tintColor = UIColor(white: 0, alpha: 0.25)
        return btn
    }()
    
    let bookmarkButton: UIButton = {
        let btn = UIButton(type: .system)
        let image = UIImage(named: "ribbon")
        btn.setImage(image, for: .normal)
        btn.tintColor = UIColor(white: 0, alpha: 0.25)
        return btn
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    let postLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "0\n", attributes: [.font: UIFont.systemFont(ofSize: 14)])
        attributedString.append(NSAttributedString(string: "posts", attributes: [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.lightGray]))
        label.attributedText = attributedString
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let followersabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "0\n", attributes: [.font: UIFont.systemFont(ofSize: 14)])
        attributedString.append(NSAttributedString(string: "followers", attributes: [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.lightGray]))
        label.attributedText = attributedString
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let followingLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "0\n", attributes: [.font: UIFont.systemFont(ofSize: 14)])
        attributedString.append(NSAttributedString(string: "following", attributes: [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.lightGray]))
        label.attributedText = attributedString
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let editProfileButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        btn.setTitle("Edit profile", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 2
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func setupUI() {
        setupProfileImageView()
        setupBottomView()
        setupUsernameLabel()
        setupStatsLabels()
        setupEditProfileButton()
    }
    
    
    fileprivate func setupProfileImageView() {
        self.addSubview(userProfileImageView)
        userProfileImageView.anchor(top: self.topAnchor, bottom: nil, leading: self.leadingAnchor, trailing: nil, paddings: .init(top: 12, left: 12, bottom: 0, right: 0), width: 80, height: 80)
    }
    
    fileprivate func setupBottomView() {
        let stackView = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        self.addSubview(stackView)
        stackView.anchor(top: nil, bottom: self.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, paddings: .zero, width: 0, height: 50)
        
        let topView = UIView()
        topView.backgroundColor = .lightGray
        self.addSubview(topView)
        topView.anchor(top: stackView.topAnchor, bottom: nil, leading: self.leadingAnchor, trailing: self.trailingAnchor, paddings: .zero, width: 0, height: 0.5)
        
        let bottomView = UIView()
        bottomView.backgroundColor = .lightGray
        self.addSubview(bottomView)
        bottomView.anchor(top: nil, bottom: stackView.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, paddings: .zero, width: 0, height: 0.5)
    }
    
    fileprivate func setupUsernameLabel() {
        self.addSubview(usernameLabel)
        usernameLabel.anchor(top: userProfileImageView.bottomAnchor, bottom: gridButton.topAnchor, leading: userProfileImageView.leadingAnchor, trailing: nil, paddings: .init(top: 0, left: 5, bottom: 0, right: 0), width: 100, height: 0)
    }
    
    fileprivate func setupStatsLabels() {
        let stackView = UIStackView(arrangedSubviews: [postLabel,followersabel,followingLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        self.addSubview(stackView)
        stackView.anchor(top: self.topAnchor, bottom: nil, leading: userProfileImageView.trailingAnchor, trailing: self.trailingAnchor, paddings: .init(top: 20, left: 12, bottom: 0, right: -12), width: 0, height: 40)
    }
    
    fileprivate func setupEditProfileButton() {
        self.addSubview(editProfileButton)
        editProfileButton.anchor(top: postLabel.bottomAnchor, bottom: nil, leading: postLabel.leadingAnchor, trailing: followingLabel.trailingAnchor, paddings: .init(top: 5, left: 0, bottom: 0, right: 0), width: 0, height: 24)
    }
    
    func setUserInfo() {
        
        usernameLabel.text = user?.username
        
        guard let imageURL = user?.profileImageUrl else { return }
        guard let url = URL(string: imageURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("error: ", error.localizedDescription)
            }
            
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.userProfileImageView.image = image
                }
            }
        }.resume()
    }
}
