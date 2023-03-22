//
//  EditProfileFooter.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 22.03.2023.
//

import UIKit

protocol EditProfileFooterDelegate: AnyObject {
    func handleLogout()
}

final class EditProfileFooter : UIView {
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        button.backgroundColor = .systemGroupedBackground
        button.layer.cornerRadius = 5
        return button
    }()
    
    weak var delegate: EditProfileFooterDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(logoutButton)
        logoutButton.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 16, paddingRight: 16, height: 50)
        logoutButton.centerY(inView: self)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleLogout() {
        delegate?.handleLogout()
    }
    
}
