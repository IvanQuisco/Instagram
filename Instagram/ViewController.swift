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
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var emailTextfield: UITextField = {
        let view = UITextField()
        view.placeholder = "Email"
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.borderStyle = .roundedRect
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var usernameTextfield: UITextField = {
        let view = UITextField()
        view.placeholder = "Username"
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.borderStyle = .roundedRect
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var passwordTextfield: UITextField = {
        let view = UITextField()
        view.placeholder = "Password"
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.borderStyle = .roundedRect
        view.isSecureTextEntry = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .cyan
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
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
        plusImageButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        plusImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        plusImageButton.heightAnchor.constraint(equalToConstant: 160).isActive = true
        plusImageButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
        
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

