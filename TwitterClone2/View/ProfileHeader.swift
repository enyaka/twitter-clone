//
//  ProfileHeader.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 7.03.2023.
//

import UIKit

class ProfileHeader : UICollectionReusableView {
    
    private lazy var containerView : UIView = {
       let view = UIView()
        view.backgroundColor = .twitterBlue
        view.addSubview(backButton)
        backButton.anchor(top: view.topAnchor, left: view.leftAnchor,paddingTop: 42, paddingLeft: 16)
        backButton.setDimensions(width: 30, height: 30)
        return view
    }()
    private lazy var backButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "baseline_arrow_back_white_24dp")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(dismissProfile), for: .touchUpInside)
        return button
    }()
    
    private let profileImageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.backgroundColor = .lightGray
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.borderWidth = 4
        return image
    }()
    
    private let editProfileFollowButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Loading", for: .normal)
        button.layer.borderColor = UIColor.twitterBlue.cgColor
        button.layer.borderWidth = 1.25
        button.setTitleColor(.twitterBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(editProfileButtonTapped), for: .touchUpInside)
        return button
    }()
    private let fullname : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Blabla ablabla"
        return label
    }()
    private let username : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        label.text = "@jesus"
        return label
    }()
    
    private let bioLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 3
        label.text = "gmkrflemkalgrklma mklfdkmgla gklmfdklma gklmfdsklmgmkf fkdjsjk fdjks jfkadjkskjnf djnksfnkjg dnjksaknj fdnjksagknjfdjakg jknfdnja n jkdj kndsnkjNFJD NKJSKNJ FKJS KDJNSNjkfnj kldakmgfdkag[;fdk gkmf dalkmglmkfdlkmgfkld lkgflkd nljgfds fknkn"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(containerView)
        containerView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 108)
        
        addSubview(profileImageView)
        profileImageView.anchor(top: containerView.bottomAnchor, left: leftAnchor, paddingTop: -24, paddingLeft: 8)
        profileImageView.setDimensions(width: 80, height: 80)
        profileImageView.layer.cornerRadius = 40
        
        addSubview(editProfileFollowButton)
        editProfileFollowButton.anchor(top: containerView.bottomAnchor, right: rightAnchor, paddingTop: 12, paddingRight: 12)
        editProfileFollowButton.setDimensions(width: 100, height: 36)
        editProfileFollowButton.layer.cornerRadius = 18
        
        let userDetailStack = UIStackView(arrangedSubviews: [fullname, username, bioLabel])
        userDetailStack.axis = .vertical
        userDetailStack.distribution = .fillProportionally
        userDetailStack.spacing = 4
        addSubview(userDetailStack)
        userDetailStack.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, right: rightAnchor,paddingTop: 8,paddingLeft: 12,paddingRight: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func dismissProfile() {
        
    }
    @objc func editProfileButtonTapped() {
        print("DEBUG: Edit button tapped")
    }
}
