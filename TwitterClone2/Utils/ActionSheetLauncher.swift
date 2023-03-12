//
//  ActionSheetLauncher.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 12.03.2023.
//

import UIKit

private let reuseIdentifier = "ActionSheetCell"

final class ActionSheetLauncher: NSObject {
    
    private let user : User
    private let tableView = UITableView()
    private var UIWindow : UIWindow?
    private lazy var blackView : UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissTapped))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    init(user: User) {
        self.user = user
        super.init()
        configure()
    }
    
    
    func show() {
        print("DEBUG: Show action sheet \(user.username)")
        let win = UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
        guard let window = win else {return}
        self.UIWindow = window
        
        window.addSubview(blackView)
        blackView.frame = window.frame
        
        window.addSubview(tableView)
        tableView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 300)
        
        UIView.animate(withDuration: 0.25) {
            self.blackView.alpha = 1
            self.tableView.frame.origin.y -= 300
        }
        
    }
    
    private func configure() {
        tableView.backgroundColor = .red
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 5
        tableView.isScrollEnabled = false
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }

    @objc func dismissTapped() {
        UIView.animate(withDuration: 0.25) {
            self.blackView.alpha = 0
            self.tableView.frame.origin.y += 300
        }
    }
    
}

extension ActionSheetLauncher : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        return cell
    }
    
    
}

