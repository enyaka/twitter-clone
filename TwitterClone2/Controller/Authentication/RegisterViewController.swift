//
//  RegisterViewController.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 1.03.2023.
//

import UIKit

final class RegisterViewController: UIViewController {
    
    private let imagePicker = UIImagePickerController()
    
    private let addPhotoButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(addPhotoTapped), for: .touchUpInside)
        return button
    }()
    
    private let emailField : FormTextFieldView = {
        let view = FormTextFieldView()
        view.setPlaceHolderAndIcon(placeHolder: "Email", icon: UIImage(named: "ic_mail_outline_white_2x-1"))
        return view
    }()
    
    private let passwordField : FormTextFieldView = {
        let view = FormTextFieldView()
        view.setPlaceHolderAndIcon(placeHolder: "Password", icon: UIImage(named: "ic_lock_outline_white_2x"))
        view.textField.isSecureTextEntry = true
        return view
    }()
    private let fullnameField : FormTextFieldView = {
        let view = FormTextFieldView()
        view.setPlaceHolderAndIcon(placeHolder: "Full name", icon: UIImage(named: "ic_mail_outline_white_2x-1"))
        return view
    }()
    
    private let usernameField : FormTextFieldView = {
        let view = FormTextFieldView()
        view.setPlaceHolderAndIcon(placeHolder: "Username", icon: UIImage(named: "ic_mail_outline_white_2x-1"))
        return view
    }()
    
    private let registerButton : AuthButton = {
        let button = AuthButton(title: "Register")
        button.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        return button
    }()
    private let backToLogin : UIButton = {
        let button = Utilities().attributedButton("Already have an account? ", "Log In")
        button.addTarget(self, action: #selector(backToLoginTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        // Do any additional setup after loading the view.
    }
    func configureUI() {
        view.backgroundColor = .twitterBlue
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        view.addSubview(addPhotoButton)
        addPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor,paddingTop: 32)
        addPhotoButton.setDimensions(width: 150, height: 150)
       
        let stack : UIStackView = UIStackView(arrangedSubviews: [emailField, passwordField, fullnameField, usernameField, registerButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: addPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32,paddingRight: 32)
        
        view.addSubview(backToLogin)
        backToLogin.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,paddingBottom: 16)
    }
    
    @objc func registerTapped() {
        
    }
    
    @objc func backToLoginTapped() {
        navigationController?.popViewController(animated: true)
    }

    @objc func addPhotoTapped() {
        present(imagePicker, animated: true) {
            
        }
    }
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else {return}
        addPhotoButton.layer.cornerRadius = 75
        addPhotoButton.layer.masksToBounds = true
        addPhotoButton.imageView?.contentMode = .scaleAspectFill
        addPhotoButton.imageView?.clipsToBounds = true
        addPhotoButton.layer.borderColor = UIColor.white.cgColor
        addPhotoButton.layer.borderWidth = 3
        self.addPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        dismiss(animated: true)
        
    }
}
