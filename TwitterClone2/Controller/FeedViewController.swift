//
//  FeedViewController.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 1.03.2023.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "TweetCell"

final class FeedViewController: UICollectionViewController {
    var user : User? {
        didSet {
            configureLeftBarButton()
        }
    }
    private var tweets = [Tweet]() {
        didSet {
            collectionView.reloadData()
        }
    }
    private lazy var profileImageView : UIImageView = {
        let profile = UIImageView()
        profile.layer.cornerRadius = 16
        profile.layer.masksToBounds = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profile.addGestureRecognizer(tap)
        profile.isUserInteractionEnabled = true
        return profile
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchTweets()
        // Do any additional setup after loading the view.
    }
    
    func configureUI() {
        
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white

        
        profileImageView.setDimensions(width: 32, height: 32)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        imageView.setDimensions(width: 44, height: 44)
        navigationItem.titleView = imageView

        
    }
    
    func configureLeftBarButton() {
        guard let user = user else {return}
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
    }
    
    func fetchTweets() {
        TweetService.shared.fetchTweets { tweets in
            self.tweets = tweets
        }
    }
    @objc func profileImageTapped() {
        print("DEBUG: GO TO USER PROFILE")
    }
    
}

extension FeedViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
        cell.delegate = self
        cell.tweet = tweets[indexPath.row]
        return cell
    }
}

extension FeedViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}

extension FeedViewController : TweetCellDelegate {
    func handleProfileImageTap() {
        let controller = ProfileViewController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
