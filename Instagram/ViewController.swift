//
//  ViewController.swift
//  Instagram
//
//  Created by Ivan Quintana on 03/08/20.
//  Copyright © 2020 Ivan Quintana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var plusImageButton: UIButton = {
        let view = UIButton(type: .system)
        let image = UIImage(named: "plus_photo")?.withRenderingMode(.alwaysOriginal)
        view.setImage(image, for: .normal)
        return view
    }()
    
    var emailTextfield: UITextField = {
        let view = UITextField()
        view.placeholder = "Email"
        view.backgroundColor = UIColor(white: 0, alpha: 0.03)
        view.borderStyle = .roundedRect
        view.font = UIFont.systemFont(ofSize: 14)
        return view
    }()
    
    var usernameTextfield: UITextField = {
        let view = UITextField()
        view.placeholder = "Username"
        view.backgroundColor = UIColor(white: 0, alpha: 0.03)
        view.borderStyle = .roundedRect
        view.font = UIFont.systemFont(ofSize: 14)
        return view
    }()
    
    var passwordTextfield: UITextField = {
        let view = UITextField()
        view.placeholder = "Password"
        view.backgroundColor = UIColor(white: 0, alpha: 0.03)
        view.borderStyle = .roundedRect
        view.font = UIFont.systemFont(ofSize: 14)
        view.isSecureTextEntry = true
        return view
    }()
    
    var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.rgb(149,204,244)
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    fileprivate func setupUI() {
        view.addSubview(plusImageButton)
        plusImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        plusImageButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                               bottom: nil,
                               leading: nil,
                               trailing: nil,
                               paddings: .init(top: 40, left: 0, bottom: 0, right: 0),
                               width: 140,
                               height: 140)
        
        
        let stackView = UIStackView(arrangedSubviews: [emailTextfield,usernameTextfield,passwordTextfield, signUpButton])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView)
        stackView.anchor(top: plusImageButton.bottomAnchor,
                         bottom: nil,
                         leading: view.leadingAnchor,
                         trailing: view.trailingAnchor,
                         paddings: .init(top: 20, left: 40, bottom: 0, right: -40),
                         width: 0,
                         height: 200)
    }
}
