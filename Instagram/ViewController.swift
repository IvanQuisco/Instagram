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
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var emailTextfield: UITextField = {
        let view = UITextField()
        view.placeholder = "Email"
        view.backgroundColor = UIColor(white: 0, alpha: 0.03)
        view.borderStyle = .roundedRect
        view.font = UIFont.systemFont(ofSize: 14)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var usernameTextfield: UITextField = {
        let view = UITextField()
        view.placeholder = "Username"
        view.backgroundColor = UIColor(white: 0, alpha: 0.03)
        view.borderStyle = .roundedRect
        view.font = UIFont.systemFont(ofSize: 14)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var passwordTextfield: UITextField = {
        let view = UITextField()
        view.placeholder = "Password"
        view.backgroundColor = UIColor(white: 0, alpha: 0.03)
        view.borderStyle = .roundedRect
        view.font = UIFont.systemFont(ofSize: 14)
        view.isSecureTextEntry = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    fileprivate func setupUI() {
        view.addSubview(plusImageButton)
        plusImageButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        plusImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        plusImageButton.heightAnchor.constraint(equalToConstant: 140).isActive = true
        plusImageButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [emailTextfield,usernameTextfield,passwordTextfield, signUpButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: plusImageButton.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            stackView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
    }

}

