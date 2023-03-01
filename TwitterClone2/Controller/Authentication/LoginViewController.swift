//
//  LoginViewController.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 1.03.2023.
//

import UIKit

final class LoginViewController: UIViewController {

    private let logo : UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "TwitterLogo")
        logo.contentMode = .scaleAspectFit
        logo.clipsToBounds = true
        return logo
    }()
    
    private let emailField : FormTextFieldView = {
        let view = FormTextFieldView()
        view.textField.setLeadingIcon(UIImage(named: "ic_mail_outline_white_2x-1"))
        view.textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return view
    }()
    
    private let passwordField : FormTextFieldView = {
        let view = FormTextFieldView()
        view.textField.setLeadingIcon(UIImage(named: "ic_lock_outline_white_2x"))
        view.textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        view.textField.isSecureTextEntry = true
        return view
    }()
    
    private let loginButton : AuthButton = {
        let button = AuthButton(title: "Login")
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        return button
    }()
    
    private let newAccount : UIButton = {
        let button = Utilities().attributedButton("Don't have an account? ", "Sign Up")
        button.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        // Do any additional setup after loading the view.
    }
    
    func configureUI() {
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(logo)
        
        logo.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        logo.setDimensions(width: 150, height: 150)
       
        let stack : UIStackView = UIStackView(arrangedSubviews: [emailField, passwordField, loginButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: logo.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 32,paddingRight: 32)
        view.addSubview(newAccount)
        newAccount.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,paddingBottom: 16)
    }
    
    @objc func login() {
        print("Login")
    }
    @objc func signUp() {
        print("Sign Up")
    }

}
