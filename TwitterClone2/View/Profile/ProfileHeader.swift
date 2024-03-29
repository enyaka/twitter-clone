//
//  ProfileHeader.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 7.03.2023.
//

import UIKit

protocol ProfileHeaderDelegate : AnyObject {
    func dissmisController()
    func editProfileFollow(_ header: ProfileHeader)
    func didSelectFilter(filter: ProfileFilterOptions)
}

final class ProfileHeader : UICollectionReusableView {
    weak var delegate : ProfileHeaderDelegate?
    
    var user : User? {
        didSet{
            configure()
        }
    }
    
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
        image.layer.masksToBounds = true
        image.backgroundColor = .lightGray
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.borderWidth = 4
        return image
    }()
    
     let editProfileFollowButton : UIButton = {
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
        return label
    }()
    private let username : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    
    private let bioLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 2
        return label
    }()
    
    private let followingLabel : UILabel = {
        let label = UILabel()
        let followTap = UITapGestureRecognizer(target: self, action: #selector(followingTapped))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(followTap)
        label.text = "2 Following"
        return label
    }()
    
    private let followersLabel : UILabel = {
        let label = UILabel()
        let followTap = UITapGestureRecognizer(target: self, action: #selector(followersTapped))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(followTap)
        label.text = "0 Followers"
        return label
    }()
    
    private let filterBar = ProfileFilterView()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        filterBar.delegate = self
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
        userDetailStack.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 12, paddingRight: 12)
        
        let followStack = UIStackView(arrangedSubviews: [followingLabel, followersLabel])
        followStack.axis = .horizontal
        followStack.distribution = .fillProportionally
        followStack.spacing = 8
        
        addSubview(followStack)
        followStack.anchor(top: userDetailStack.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 12)
        
        addSubview(filterBar)
        filterBar.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 50)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        guard let user = user else {return}
        let viewModel = ProfileHeaderViewModel(user: user)
        profileImageView.sd_setImage(with: user.profileImageUrl)
        editProfileFollowButton.setTitle(viewModel.actionButtonTitle, for: .normal)
        
        fullname.text = user.fullname
        username.text = viewModel.usernameText
        followingLabel.attributedText = viewModel.followingString
        followersLabel.attributedText = viewModel.followersString
        bioLabel.text = user.bio
    }
    
    @objc func dismissProfile() {
        delegate?.dissmisController()
    }
    
    @objc func editProfileButtonTapped() {
        delegate?.editProfileFollow(self)
    }
    
    @objc func followingTapped() {
        
    }
    
    @objc func followersTapped() {
        
    }
    
}

extension ProfileHeader: ProfileFilterViewDelegate {
    func filterView(didSelectOption option: ProfileFilterOptions) {
        delegate?.didSelectFilter(filter: option)
    }
}
