//
//  MainTabController.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 1.03.2023.
//

import UIKit
import Firebase

enum ActionButtonConfiguration {
    case tweet(image: String)
    case message(image: String)
}

final class MainTabController: UITabBarController {
    var user : User? {
        didSet {
            guard let nav = viewControllers?[0] as? UINavigationController else {return}
            guard let feed = nav.viewControllers.first as? FeedViewController else {return}
            feed.user = user
        }
    }
    
    private var buttonConfig: ActionButtonConfiguration = .tweet(image: "new_tweet")
    
    private let actionButton : UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .twitterBlue
        authenticateUserAndConfigureUI()
       
    }
    
    func configureUI() {
        self.delegate = self
        let buttonHeight : CGFloat = 56
        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 64, paddingRight: 16, width: 56, height: buttonHeight)
        actionButton.layer.cornerRadius = buttonHeight / 2

       
    }
    
    func configureViewControllers() {
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
            let appearance = UITabBarAppearance()
            appearance.configureWithDefaultBackground()
            appearance.backgroundColor = .systemBackground
            tabBar.standardAppearance = appearance
        }
    
        let feedTab = templateNavigationController(image: UIImage(named: "home_unselected"), rootViewController: FeedViewController(collectionViewLayout: UICollectionViewFlowLayout()))
        let exploreTab = templateNavigationController(image: UIImage(named: "search_unselected"), rootViewController: ExploreViewController())
        let notificationsTab = templateNavigationController(image: UIImage(named: "like_unselected"), rootViewController: NotificationsViewController())
        let conservationsTab = templateNavigationController(image: UIImage(named: "ic_mail_outline_white_2x-1"), rootViewController: ConservationsViewController())

        viewControllers = [feedTab, exploreTab, notificationsTab, conservationsTab]
    }
    
    func templateNavigationController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.setDefaultNavBar()
        nav.tabBarItem.image = image
        return nav
    }
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        UserSevice.shared.fetchUser(uid: uid) { user in
            self.user = user
        }
    }
    
    func authenticateUserAndConfigureUI() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginViewController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
        } else {
            configureViewControllers()
            configureUI()
            fetchUser()
        }
    }
   
    
    @objc func tapped() {
        let controller : UIViewController
        guard let user = user else {return}
        switch buttonConfig {
            case .tweet(_):
                controller = UploadTweetController(user: user, config: .tweet)
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                nav.setDefaultNavBar()
                present(nav, animated: true)
            case .message(_):
            selectedIndex = 1
        }
        
    }

}

extension MainTabController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let index = viewControllers?.firstIndex(of: viewController)
        buttonConfig = index == 3 ? .message(image: "mail") : .tweet(image: "new_tweet")
        self.actionButton.setImage(UIImage(named: {
            switch buttonConfig {
            case .tweet(image: let image): return image
            case .message(image: let image): return image
            }
        }()), for: .normal)
        
    }
}
