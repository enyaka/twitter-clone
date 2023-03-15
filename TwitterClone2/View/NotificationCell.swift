//
//  NotificationCell.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 14.03.2023.
//

import UIKit

protocol NotificationCellDelegate : AnyObject {
    func didTapProfileImage(_ cell: NotificationCell)
    func didTapFollow(_ cell: NotificationCell)
}

final class NotificationCell : UITableViewCell {
    
    var notification : Notification? {
        didSet {
            configure()
        }
    }
    
    private lazy var profileImageView : UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.setDimensions(width: 40, height: 40)
        image.layer.cornerRadius = 40 / 2
        image.backgroundColor = .twitterBlue
        let tap = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        image.addGestureRecognizer(tap)
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private let notificationLabel : UILabel = {
       let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Test notification message"
        return label
    }()
    
    private lazy var followButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Loading", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.twitterBlue.cgColor
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(followTapped), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: NotificationCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stack = UIStackView(arrangedSubviews: [profileImageView, notificationLabel])
        stack.spacing = 8
        stack.axis = .horizontal
        stack.alignment = .center
        contentView.addSubview(stack)
        stack.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        stack.anchor(right: rightAnchor, paddingRight: 12)
        
        addSubview(followButton)
        followButton.centerY(inView: self)
        followButton.setDimensions(width: 92, height: 32)
        followButton.layer.cornerRadius = 32 / 2
        followButton.anchor(right: rightAnchor, paddingRight: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        guard let notification = notification else {return}
        let viewModel = NotificationViewModel(notification: notification)
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        notificationLabel.attributedText = viewModel.notificationText
        followButton.isHidden = viewModel.shouldHideFollowButton
        followButton.setTitle(viewModel.followButtonText, for: .normal)
    }
    
    @objc func profileImageTapped() {
        delegate?.didTapProfileImage(self)
    }
    
    @objc func followTapped() {
        delegate?.didTapFollow(self)
    }
}
