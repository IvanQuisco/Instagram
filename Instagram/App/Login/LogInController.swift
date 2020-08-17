//
//  LogInController.swift
//  Instagram
//
//  Created by Ivan Quintana on 17/08/20.
//  Copyright © 2020 Ivan Quintana. All rights reserved.
//

import UIKit

class LogInController: UIViewController {
    
    let signUpButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Don't have an account? Sign Up.", for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(signUpButton)
        signUpButton.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddings: .init(top: 0, left: 0, bottom: -10, right: 0), width: 0, height: 50)
    }
    
    @objc func signUpButtonTapped() {
        let signUpController = SignUpController()
        self.navigationController?.pushViewController(signUpController, animated: true)
    }
}

