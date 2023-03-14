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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isHidden = false
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
            self.checkUserlikedTweets(tweets)
        }
    }
    
    func checkUserlikedTweets(_ tweets: [Tweet]) {
        for (index, tweet) in tweets.enumerated() {
            TweetService.shared.checkIfUserLikedTweet(tweet) { didLike in
                guard didLike == true else {return}
                self.tweets[index].didLike = true
            }
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tweetView = TweetViewController(tweet: tweets[indexPath.row])
        navigationController?.pushViewController(tweetView, animated: true)
    }
}

extension FeedViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        
        let viewModel = TweetViewModel(tweet: tweets[indexPath.row])
        let font = UIFont.systemFont(ofSize: 14)
        let height = viewModel.size(forWidth: view.frame.width - 90, withFont: font).height
        return CGSize(width: view.frame.width, height: height + 90)
    }
}

extension FeedViewController : TweetCellDelegate {
    func handleLikeTap(_ cell: TweetCell) {
        
        guard let tweet = cell.tweet else {return}
        TweetService.shared.likeTweet(tweet: tweet) { err, ref in
            cell.tweet?.didLike.toggle()
            let likes = tweet.didLike ? tweet.likes - 1 : tweet.likes + 1
            cell.tweet?.likes = likes
        }
        
    }
    
    func handleReplyTap(_ cell: TweetCell) {
        guard let tweet = cell.tweet else {return}
        let controller = UploadTweetController(user: tweet.user, config: .retweet(tweet))
        let nav = UINavigationController(rootViewController: controller)
        nav.setDefaultNavBar()
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    func handleProfileImageTap(_ cell: TweetCell) {
        guard let user = cell.tweet?.user else {return}
        let controller = ProfileViewController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
}
