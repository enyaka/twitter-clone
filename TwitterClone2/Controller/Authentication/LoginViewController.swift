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
        view.setPlaceHolderAndIcon(placeHolder: "Email", icon: UIImage(named: "ic_mail_outline_white_2x-1"))
        return view
    }()
    
    private let passwordField : FormTextFieldView = {
        let view = FormTextFieldView()
        view.setPlaceHolderAndIcon(placeHolder: "Password", icon: UIImage(named: "ic_lock_outline_white_2x"))
        view.textField.isSecureTextEntry = true
        return view
    }()
    
    private let loginButton : AuthButton = {
        let button = AuthButton(title: "Login")
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        return button
    }()
    
    private let newAccount : UIButton = {
        let button = Utilities().attributedButton("Don't have an account? ", "Sign Up")
        button.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
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
    
    @objc func loginTapped() {
        guard let email = emailField.textField.text else {return}
        guard let password = passwordField.textField.text else {return}
        AuthService.shared.logUserIn(email: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Error loggin user -> \(error.localizedDescription)")
                return
            }
            let window = UIApplication
                .shared
                .connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow }
            guard let window = window?.rootViewController as? MainTabController else {return}
            window.authenticateUserAndConfigureUI()
            self.dismiss(animated: true)
        }
    }
    @objc func signUpTapped() {
        let controller = RegisterViewController()
        navigationController?.pushViewController(controller, animated: true)
    }

}
