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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func setupUI() {
        self.addSubview(userProfileImageView)
        userProfileImageView.anchor(top: self.topAnchor, bottom: nil, leading: self.leadingAnchor, trailing: nil, paddings: .init(top: 12, left: 12, bottom: 0, right: 0), width: 80, height: 80)
    }
    
    func setUserInfo() {
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
