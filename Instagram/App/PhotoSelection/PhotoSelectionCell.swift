//
//  PhotoSelectionCell.swift
//  Instagram
//
//  Created by Ivan Quintana on 20/08/20.
//  Copyright © 2020 Ivan Quintana. All rights reserved.
//

import UIKit

class PhotoSelectionCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .green
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI() {
        self.addSubview(imageView)
        imageView.anchor(top: self.topAnchor, bottom: self.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, paddings: .zero, width: 0, height: 0)
    }
}
