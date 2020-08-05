//
//  ViewController.swift
//  Instagram
//
//  Created by Ivan Quintana on 03/08/20.
//  Copyright © 2020 Ivan Quintana. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class ViewController: UIViewController {
    
    let plusImageButton: UIButton = {
        let view = UIButton(type: .system)
        let image = UIImage(named: "plus_photo")?.withRenderingMode(.alwaysOriginal)
        view.setImage(image, for: .normal)
        view.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
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
    
    let usernameTextfield: UITextField = {
        let view = UITextField()
        view.placeholder = "Username"
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
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.rgb(149,204,244)
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.isEnabled = false
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
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

//MARK: - Targets

extension ViewController {
    
    @objc func signUpButtonTapped() {
        guard let email = emailTextfield.text, !email.isEmpty else {
            return
        }
        guard let username = usernameTextfield.text, !username.isEmpty else {
            return
        }
        guard let password = passwordTextfield.text, !password.isEmpty else {
            return
        }
        
        //Prepare image to be uploaded
        guard let image = plusImageButton.imageView?.image else {return}
        guard let data = image.jpegData(compressionQuality: 0.1) else {return}
        
        //Upload image
        let imageFileName = UUID().uuidString
        let reference = Storage.storage().reference().child("profile_images").child(imageFileName)
        
        reference.putData(data, metadata: nil) { (metadata, error) in
            if let error = error {
                print("Failed to upload profile image to storage: ", error)
                return
            }
            
            print("image uploaded")
            
            //Get image URL
            if metadata != nil {
                reference.downloadURL(completion: { (url, error) in
                    if let error = error {
                        print("failed getting image url: ", error)
                        return
                    }
                    
                    //Create user
                    if let imageUrl = url {
                        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                            if let error = error {
                                print("Sth went wrong: ", error)
                                return
                            }
                            
                            //Upload user info
                            self.uploadInfo(for: user, username: username, imageURL: imageUrl.absoluteString)

                        }
                    }
                })
            }
        }
    }
    
    func uploadInfo(for user: AuthDataResult?, username: String, imageURL: String ) {
        guard let user = user else {return}

        let dictionaryValues = [
            "username": username,
            "profileImageUrl": imageURL
        ]
        let values = [user.user.uid: dictionaryValues]

        Database.database().reference().child("users").updateChildValues(values) { (error, reference) in
            if let error = error {
                print("Failled to save user info into db: ", error)
                return
            }
            print("Successfully saved user info to db")
        }
    }
    
    @objc func textfieldTextChanged() {
        let isSignUpButtonEnabled = !(emailTextfield.text?.isEmpty ?? true) &&
            !(usernameTextfield.text?.isEmpty ?? true) &&
            !(passwordTextfield.text?.isEmpty ?? true)
        signUpButton.isEnabled = isSignUpButtonEnabled
        signUpButton.backgroundColor = isSignUpButtonEnabled ? UIColor.rgb(17, 154, 237) : UIColor.rgb(149,204,244)
    }
    
    @objc func plusButtonTapped() {
        let pickerController = UIImagePickerController()
        pickerController.allowsEditing = true
        pickerController.delegate = self
        self.present(pickerController, animated: true, completion: nil)
        
    }
}

//MARK: - ImagePickerViewDelegate
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[.editedImage] as? UIImage {
            plusImageButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        } else if let originalImage = info[.originalImage] as? UIImage {
            plusImageButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        self.updatePlusButtonUIAfterSelection()
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func updatePlusButtonUIAfterSelection() {
        plusImageButton.layer.cornerRadius = plusImageButton.frame.width/2
        plusImageButton.layer.masksToBounds = true
        plusImageButton.layer.borderWidth = 2
        plusImageButton.layer.borderColor = UIColor.black.cgColor
    }
}
