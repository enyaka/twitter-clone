//
//  FeedViewController.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 1.03.2023.
//

import UIKit

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        // Do any additional setup after loading the view.
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
    
}
