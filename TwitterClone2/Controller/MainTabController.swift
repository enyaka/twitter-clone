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
            appearance.configureWithDefaultBackground()
            appearance.backgroundColor = .systemBackground
            tabBar.standardAppearance = appearance
        }
    
        let feedTab = templateNavigationController(image: UIImage(named: "home_unselected"), rootViewController: FeedViewController())
        let exploreTab = templateNavigationController(image: UIImage(named: "search_unselected"), rootViewController: ExploreViewController())
        let notificationsTab = templateNavigationController(image: UIImage(named: "like_unselected"), rootViewController: NotificationsViewController())
        let conservationsTab = templateNavigationController(image: UIImage(named: "ic_mail_outline_white_2x-1"), rootViewController: ConservationsViewController())

        viewControllers = [feedTab, exploreTab, notificationsTab, conservationsTab]
    }
    
    func templateNavigationController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()
        navigationBarAppearance.backgroundColor = .systemBackground
        nav.navigationBar.standardAppearance = navigationBarAppearance
        nav.navigationBar.compactAppearance = navigationBarAppearance
        nav.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        
        nav.tabBarItem.image = image
        return nav
    }

}
