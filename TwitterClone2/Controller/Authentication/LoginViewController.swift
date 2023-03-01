//
//  LoginViewController.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 1.03.2023.
//

import UIKit

class LoginViewController: UIViewController {

    private let logo : UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "TwitterLogo")
        logo.contentMode = .scaleAspectFit
        logo.clipsToBounds = true
        return logo
    }()
//    private lazy var emailContainerView : UIView = {
//        let view = UIView()
//        view.backgroundColor = .red
//
//        return view
//    }()
//    private lazy var passwordContainerView : UIView = {
//       let view = UIView()
//        view.backgroundColor = .green
//        return view
//    }()
    
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
        
//        emailContainerView.anchor(height: 50)
//        passwordContainerView.anchor(height: 50)
//        let stack : UIStackView = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView])
       
        let stack : UIStackView = UIStackView(arrangedSubviews: [emailField, passwordField])
        stack.axis = .vertical
        stack.spacing = 8
        
        view.addSubview(stack)
        stack.anchor(top: logo.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 16,paddingRight: 16)
    }

}
