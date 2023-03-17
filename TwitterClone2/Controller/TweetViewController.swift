//
//  TweetViewController.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 9.03.2023.
//

import UIKit

private let reuseIdentifier : String = "TweetCell"
private let reuseHeaderIdentifier : String = "TweetHeader"


final class TweetViewController : UICollectionViewController {
    
    private var actionSheetLauncher : ActionSheetLauncher!
    private let tweet : Tweet
    private var replies = [Tweet]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    init(tweet: Tweet) {
        self.tweet = tweet
        super.init(collectionViewLayout: UICollectionViewFlowLayout())

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        fetchReplies()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isHidden = false
    }
    
    func configureCollectionView() {
        
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(TweetHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: reuseHeaderIdentifier)
        collectionView.backgroundColor = .white
        navigationItem.title = "Tweet"
        
    }
    
    func fetchReplies() {
        TweetService.shared.fetchReplies(forTweet: tweet) { replies in
            self.replies = replies
        }
    }
    
    fileprivate func showActionSheet(forUser user: User) {
        actionSheetLauncher = ActionSheetLauncher(user: user)
        actionSheetLauncher.delegate = self
        actionSheetLauncher.show()
    }
}

extension TweetViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return replies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
        cell.tweet = replies[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseHeaderIdentifier, for: indexPath) as! TweetHeader
        header.tweet = tweet
        header.delegate = self
        return header
    }
}

extension TweetViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        let header = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: IndexPath(row: 0, section: section)) as! TweetHeader
//        var size = header.captionLabel.sizeThatFits(CGSize(width: collectionView.frame.width - 40, height: .greatestFiniteMagnitude))
//        size.height += 230
        
        let viewModel = TweetViewModel(tweet: tweet)
        let font = UIFont.systemFont(ofSize: 20)
        let height = viewModel.size(forWidth: view.frame.width - 32, withFont: font).height
        return CGSize(width: view.frame.width, height: height + 230)
        
//        let viewModel = TweetViewModel(tweet: tweet)
//        let captionHeight = viewModel.size(forWidth: view.frame.width).height
//        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}

extension TweetViewController : TweetHeaderDelegate {
    
    
    func showActionSheet() {
        if tweet.user.isCurrentUser {
            showActionSheet(forUser: tweet.user)
        } else {
            UserSevice.shared.checkIfUserFollowed(uid: tweet.user.uid) { isFollowed in
                var user = self.tweet.user
                user.isFollowed = isFollowed
                self.showActionSheet(forUser: user)
            }
        }
    }
}

extension TweetViewController : ActionSheetLauncherDelegate {
    func didSelect(option: ActionSheetOptions) {
        switch option {
        case .follow(let user):
            UserSevice.shared.followUser(uid: user.uid) { err, ref in
                print("DEBUG: Did follow user -> \(user.fullname)")
            }
        case .unfollow(let user):
            UserSevice.shared.unfollowUser(uid: user.uid) { err, ref in
                print("DEBUG: Did unfollow user -> \(user.fullname)")
            }
        case .report:
            print("DEBUG: Reported")
        case .delete:
            print("DEBUG: deleted")
        case .block:
            print("DEBUG: Blocked")
        }
    }    
}
