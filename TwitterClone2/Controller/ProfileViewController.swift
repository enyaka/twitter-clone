//
//  ProfileViewController.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 7.03.2023.
//

import UIKit
private let reuseIdentifier = "TweetCell"
private let headerIdentifier = "ProfileHeader"

final class ProfileViewController : UICollectionViewController {
    
    private var user : User
    private var selectedType : ProfileFilterOptions = .tweets {
        didSet { collectionView.reloadData() }
    }
    
    private var tweets = [Tweet]()
    
    private var likedTweets = [Tweet]()
    
    private var replies = [Tweet]()
    
    private var currentDataSource : [Tweet] {
        switch selectedType {
        case .tweets: return tweets
        case .replies: return replies
        case .likes: return likedTweets
        }
    }
    
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        fetchTweets()
        fetchReplies()
        fethLikedTweets()
        checkIfUserIsFollowed()
        fetchUserStats()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
    }
    
    
    func configureCollectionView() {
        
        
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
        guard let tabHeight = tabBarController?.tabBar.frame.height else { return }
        collectionView.contentInset.bottom = tabHeight
        
    }
    
    func fetchTweets() {
        TweetService.shared.fetchTweets(forUser: user) { tweets in
            self.tweets = tweets
        }
    }
    
    func checkIfUserIsFollowed() {
        UserSevice.shared.checkIfUserFollowed(uid: user.uid) { isFollowed in
            self.user.isFollowed = isFollowed
        }
    }
    
    func fetchUserStats() {
        UserSevice.shared.fetchUserStats(uid: user.uid) { stats in
            self.user.stats = stats
            self.collectionView.reloadData()
        }
    }
    func fethLikedTweets() {
        TweetService.shared.fetchLikes(forUser: user) { tweets in
            self.likedTweets = tweets
        }
    }
    func fetchReplies() {
        TweetService.shared.fetchReplies(forUser: user) { tweets in
            self.replies = tweets
            
        }
    }
    
}

extension ProfileViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentDataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
        cell.tweet = currentDataSource[indexPath.row]
        return cell
    }
}

extension ProfileViewController {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! ProfileHeader
        header.delegate = self
        header.user = user
        return header
    }
}

extension ProfileViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewModel = TweetViewModel(tweet: currentDataSource[indexPath.row])
        let font = UIFont.systemFont(ofSize: 14)
        let height = viewModel.size(forWidth: view.frame.width - 90, withFont: font).height
        return CGSize(width: view.frame.width, height: height + 90)
    }
}

extension ProfileViewController : ProfileHeaderDelegate {
    func didSelectFilter(filter: ProfileFilterOptions) {
        self.selectedType = filter
    }
    
    func editProfileFollow(_ header: ProfileHeader) {
        if user.isCurrentUser {
            print("DEBUG: Show edit profile controller")
            return
        }
        if user.isFollowed {
            UserSevice.shared.unfollowUser(uid: user.uid) { err, ref in
                self.user.isFollowed = false
                self.fetchUserStats()
            }
        } else {
            UserSevice.shared.followUser(uid: user.uid) { err, ref in
                self.user.isFollowed = true
                self.fetchUserStats()
                NotificationService.shared.uploadNotification(type: .follow, user: self.user)
            }
        }
    }
    
    func dissmisController() {
        navigationController?.popViewController(animated: true)
    }
    
    
}
