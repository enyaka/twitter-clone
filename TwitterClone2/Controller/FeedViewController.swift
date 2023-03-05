//
//  FeedViewController.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 1.03.2023.
//

import UIKit
import SDWebImage

final class FeedViewController: UIViewController {
    var user : User? {
        didSet {
            configureLeftBarButton()
        }
    }
    private let profileImageView : UIImageView = {
        let profile = UIImageView()
        profile.layer.cornerRadius = 16
        profile.layer.masksToBounds = true
        return profile
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        // Do any additional setup after loading the view.
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        profileImageView.setDimensions(width: 32, height: 32)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView

        
    }
    
    func configureLeftBarButton() {
        guard let user = user else {return}
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
    }
    
}
