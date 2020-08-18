//
//  LogInController.swift
//  Instagram
//
//  Created by Ivan Quintana on 17/08/20.
//  Copyright © 2020 Ivan Quintana. All rights reserved.
//

import UIKit

class LogInController: UIViewController {
    
    let logoView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(0, 120, 175)
        let logoImageView = UIImageView(image: UIImage(named: "Instagram_logo_white"))
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.contentMode = .scaleAspectFill
        view.addSubview(logoImageView)
        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        return view
    }()
    
    
    let emailTextfield: UITextField = {
        let view = UITextField()
        view.placeholder = "Email"
        view.backgroundColor = UIColor(white: 0, alpha: 0.03)
        view.borderStyle = .roundedRect
        view.font = UIFont.systemFont(ofSize: 14)
        view.keyboardType = .emailAddress
        view.autocapitalizationType = .none
        view.addTarget(self, action: #selector(textfieldTextChanged), for: .editingChanged)
        return view
    }()
    
    let passwordTextfield: UITextField = {
        let view = UITextField()
        view.placeholder = "Password"
        view.backgroundColor = UIColor(white: 0, alpha: 0.03)
        view.borderStyle = .roundedRect
        view.font = UIFont.systemFont(ofSize: 14)
        view.isSecureTextEntry = true
        view.autocapitalizationType = .none
        view.addTarget(self, action: #selector(textfieldTextChanged), for: .editingChanged)
        return view
    }()
    
    let logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.rgb(149,204,244)
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.isEnabled = false
        button.addTarget(self, action: #selector(logIntButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let dontHaveAnAccountButton: UIButton = {
        let btn = UIButton(type: .system)
        let attributed = NSMutableAttributedString(string: "Don't have an account? ", attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray])
        attributed.append(NSAttributedString(string: "Sign Up.", attributes: [.font: UIFont.boldSystemFont(ofSize: 14) ,
        .foregroundColor: UIColor.rgb(17, 154, 237)]))
        btn.setAttributedTitle(attributed, for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(dontHaveAnAccountButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(dontHaveAnAccountButton)
        dontHaveAnAccountButton.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddings: .init(top: 0, left: 0, bottom: -10, right: 0), width: 0, height: 50)
        
        view.addSubview(logoView)
        logoView.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddings: .zero, width: 0, height: 180)
        
        let stackView = UIStackView(arrangedSubviews: [emailTextfield,passwordTextfield, logInButton])
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView)
        stackView.anchor(top: logoView.bottomAnchor,
                         bottom: nil, 
                         leading: view.leadingAnchor,
                         trailing: view.trailingAnchor,
                         paddings: .init(top: 40, left: 40, bottom: 0, right: -40),
                         width: 0,
                         height: 140)
        
        
    }
    
    @objc func dontHaveAnAccountButtonTapped() {
        let signUpController = SignUpController()
        self.navigationController?.pushViewController(signUpController, animated: true)
    }
}


extension LogInController {
    @objc func logIntButtonTapped() {
        
    }
    
    
    @objc func textfieldTextChanged() {
        let isSignUpButtonEnabled = !(emailTextfield.text?.isEmpty ?? true) &&
            !(passwordTextfield.text?.isEmpty ?? true)
        logInButton.isEnabled = isSignUpButtonEnabled
        logInButton.backgroundColor = isSignUpButtonEnabled ? UIColor.rgb(17, 154, 237) : UIColor.rgb(149,204,244)
    }
}
