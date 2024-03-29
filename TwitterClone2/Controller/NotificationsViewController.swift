//
//  NotificationsViewController.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 1.03.2023.
//

import UIKit

private let reuseIdentifier = "NotificationCell"

final class NotificationsViewController: UITableViewController {
    
    private var pressed : Bool = false

    private var notifications = [Notification]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchNotifications()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isHidden = false
        pressed = false
    }
    
    func configureUI() {
        tableView.register(NotificationCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        view.backgroundColor = .systemBackground
        navigationItem.title = "Notifications"
        
        let refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    }
    
    func fetchNotifications() {
        refreshControl?.beginRefreshing()
        NotificationService.shared.fetchNotifications { notifications in
            
            self.notifications = notifications
            self.checkIfUserIsFollowed(notifications: notifications)
        }
        refreshControl?.endRefreshing()
    }
    
    func checkIfUserIsFollowed(notifications: [Notification]) {
        guard !notifications.isEmpty else {return}
        
        notifications.forEach { notification in
            guard case .follow = notification.type else {return}
            let user = notification.user
            UserSevice.shared.checkIfUserFollowed(uid: user.uid) { isFollowed in
                if let index = self.notifications.firstIndex(where: { $0.user.uid == notification.user.uid }) {
                    self.notifications[index].user.isFollowed = isFollowed
                }
            }
        }

    }
    
    @objc func handleRefresh() {
        fetchNotifications()
    }
    
}

extension NotificationsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notifications.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! NotificationCell
        cell.delegate = self
        cell.notification = notifications[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let notification = notifications[indexPath.row]
        guard let tweetID = notification.tweetID else {pressed = false; return}
        if !pressed {
            pressed = true
            TweetService.shared.fetchTweet(withTweetID: tweetID) { tweet in
                let controller = TweetViewController(tweet: tweet)
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }
        
    }
    
}

extension NotificationsViewController : NotificationCellDelegate {
    func didTapFollow(_ cell: NotificationCell) {
        guard let user = cell.notification?.user else {return}
        
        if user.isFollowed {
            UserSevice.shared.unfollowUser(uid: user.uid) { err, data in
                cell.notification?.user.isFollowed = false
            }
        } else {
            UserSevice.shared.followUser(uid: user.uid) { err, data in
                cell.notification?.user.isFollowed = true

            }
        }
    }
    
    func didTapProfileImage(_ cell: NotificationCell) {
        guard let user = cell.notification?.user else {return}
        let controller = ProfileViewController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
}

