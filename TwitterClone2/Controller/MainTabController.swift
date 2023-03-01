//
//  MainTabController.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 1.03.2023.
//

import UIKit

class MainTabController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
        // Do any additional setup after loading the view.
    }
    
    
    func configureViewControllers() {
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .systemBackground
            tabBar.standardAppearance = appearance
        }
        let feed = FeedViewController()
        feed.tabBarItem.image = UIImage(named: "home_unselected")
        let explore = ExploreViewController()
        explore.tabBarItem.image = UIImage(named: "search_unselected")
        let notifications = NotificationsViewController()
        notifications.tabBarItem.image = UIImage(named: "search_unselected")
        let conservations = ConservationsViewController()
        conservations.tabBarItem.image = UIImage(named: "search_unselected")

        viewControllers = [feed, explore, notifications, conservations]
    }

}
