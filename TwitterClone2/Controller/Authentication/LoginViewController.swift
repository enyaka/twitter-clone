//
//  LoginViewController.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 1.03.2023.
//

import UIKit

class LoginViewController: UIViewController {

    let logo : UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "TwitterLogo")
        logo.contentMode = .scaleAspectFit
        logo.clipsToBounds = true
        return logo
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
    }

}
