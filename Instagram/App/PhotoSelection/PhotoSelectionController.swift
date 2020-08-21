//
//  PhotoSelectionController.swift
//  Instagram
//
//  Created by Ivan Quintana on 19/08/20.
//  Copyright © 2020 Ivan Quintana. All rights reserved.
//

import UIKit
import Photos

class PhotoSelectionController: UICollectionViewController {
    
    let cellID = "cellID"
    let headerID = "headerID"
    
    var userImages: [UIImage] = []
    var assets: [PHAsset] = []
    var selectedImage: UIImage?
    
    var header: PhotoSelectionHeader?
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCollectionView()
        fetchImages()
    }
    
    fileprivate func setupNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .black
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonTapped))
    }
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(PhotoSelectionCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(PhotoSelectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
    }
    
    
    fileprivate func fetchImages() {
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = .max
        let sortDes = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchOptions.sortDescriptors = [sortDes]
        
        let allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        DispatchQueue.global(qos: .background).async {
            allPhotos.enumerateObjects { (asset, count, stop) in
                let imageManager = PHImageManager.default()
                let targetSize = CGSize(width: 200, height: 200)
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options) { (image, info) in
                    
                    if let image = image {
                        self.userImages.append(image)
                        self.assets.append(asset)
                        
                        if self.selectedImage == nil {
                            self.selectedImage = image
                        }
                        
                    }

                    
                    if count == self.userImages.count - 1 {
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    }
                }
            }
        }
        
    }
}

extension PhotoSelectionController {
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func nextButtonTapped() {
        let sharePhotoController = SharePhotoController()
        sharePhotoController.selectedView = header?.imageView.image
        self.navigationController?.pushViewController(sharePhotoController, animated: true)
    }
}

extension PhotoSelectionController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userImages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PhotoSelectionCell
        cell.imageView.image = userImages[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! PhotoSelectionHeader
        header.imageView.image = selectedImage
        self.header = header
        if let selected = selectedImage {
            if let index = userImages.firstIndex(of: selected) {
                let asset = self.assets[index]
                let imageManager = PHImageManager.default()
                let targetSize = CGSize(width: 700, height: 700)
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options) { (image, info) in
                    
                    if let image = image {
                        header.imageView.image = image
                    }
                }
            }
        }
        
        return header
    }
}

extension PhotoSelectionController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedImage = userImages[indexPath.item]
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}


extension PhotoSelectionController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 3) / 4
        return .init(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let side = view.frame.width
        return .init(width: side, height: side)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 1, left: 0, bottom: 0, right: 0)
    }
}
