//
//  TweetHeadr.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 9.03.2023.
//

import UIKit

protocol TweetHeaderDelegate : AnyObject {
    func showActionSheet()
}

final class TweetHeader : UICollectionReusableView {
    
    weak var delegate : TweetHeaderDelegate?
    
    var tweet : Tweet? {
        didSet {
            configure()
        }
    }
    
    private lazy var profileImageView : UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.setDimensions(width: 48, height: 48)
        image.layer.cornerRadius = 48 / 2
        image.backgroundColor = .twitterBlue
        let tap = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        image.addGestureRecognizer(tap)
        image.isUserInteractionEnabled = true
        return image
    }()
    private let replyLabel : UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private let fullname : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    private let username : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    private let captionLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.text = "Lorem ipsum blabla lorem lorem ipsum ipsum"
        return label
    }()
    
    private let dateLabel : UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "6.33 PM - 01/02/2022"
        label.textAlignment = .left
        return label
    }()
    
    private let retweetsLabel : UILabel = UILabel()
    
    private let  likesLabel : UILabel = UILabel()
    
    private lazy var statsView : UIView = {
        let view = UIView()
        let divider1 = UIView()
        divider1.backgroundColor = .systemGroupedBackground
        view.addSubview(divider1)
        divider1.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 8, height: 1.0)
        let stack = UIStackView(arrangedSubviews: [retweetsLabel, likesLabel])
        stack.axis = .horizontal
        stack.spacing = 12
        view.addSubview(stack)
        stack.centerY(inView: view)
        stack.anchor(left: view.leftAnchor, paddingLeft: 16)
        
        let divider2 = UIView()
        divider2.backgroundColor = .systemGroupedBackground
        view.addSubview(divider2)
        divider2.anchor(left: view.leftAnchor,bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, height: 1.0)
        
        return view
    }()
    
    private lazy var optionsButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "down_arrow_24pt"), for: .normal)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
        return button
    }()
    
    private lazy var commentButton : UIButton = {
        let button = createButton(withImageName: "comment")
        button.addTarget(self, action: #selector(commentTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var retweetButton : UIButton = {
        let button = createButton(withImageName: "retweet")
        button.addTarget(self, action: #selector(retweetTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var likeButton : UIButton = {
        let button = createButton(withImageName: "like")
        button.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var shareButton : UIButton = {
        let button = createButton(withImageName: "share")
        button.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        let labelStack = UIStackView(arrangedSubviews: [fullname, username])
        labelStack.axis = .vertical
        labelStack.spacing = -6
        
        let imageCaptionStack = UIStackView(arrangedSubviews: [profileImageView, labelStack])
        imageCaptionStack.spacing = 12
        
        let stack = UIStackView(arrangedSubviews: [replyLabel, imageCaptionStack])
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fillProportionally
        
        addSubview(stack)
        stack.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, paddingTop: 16, paddingLeft: 16)
        addSubview(optionsButton)
        optionsButton.centerY(inView: stack)
        optionsButton.anchor(right: rightAnchor, paddingRight: 8)
        
        addSubview(captionLabel)
        captionLabel.anchor(top: stack.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 20,paddingLeft: 16,paddingRight: 16)
        
        addSubview(dateLabel)
        dateLabel.anchor(top: captionLabel.bottomAnchor, left: leftAnchor, paddingTop: 20, paddingLeft: 16)
        addSubview(statsView)
        statsView.anchor(top: dateLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 20, height: 40)
        let actionStack = UIStackView(arrangedSubviews: [commentButton, retweetButton, likeButton, shareButton])
        actionStack.spacing = 72
        addSubview(actionStack)
        actionStack.centerX(inView: self)
        actionStack.anchor(bottom: bottomAnchor, paddingBottom: 12)
        
    }
    
    func configure() {
        guard let tweet = tweet else {return}

        let viewmodel = TweetViewModel(tweet: tweet)
        replyLabel.isHidden = viewmodel.isReply
        replyLabel.text = viewmodel.replyText
        captionLabel.text = tweet.caption
        fullname.text = tweet.user.fullname
        username.text = viewmodel.usernameText
        profileImageView.sd_setImage(with: viewmodel.profileImageUrl)
        dateLabel.text = viewmodel.headerTimestamp
        likesLabel.attributedText = viewmodel.likesAttributedString
        likeButton.setImage(viewmodel.likeButtonImage, for: .normal)
        likeButton.tintColor = viewmodel.likeButtonTintColor
        retweetsLabel.attributedText = viewmodel.retweetsAttributedString
        
    }
    
    @objc func profileImageTapped() {
        print("DEBUG: Go to user profile")

    }
    
    @objc func showActionSheet() {
        delegate?.showActionSheet()
    }
    
    @objc func commentTapped() {
    }
    
    @objc func retweetTapped() {

    }
    
    @objc func likeTapped() {

    }
    
    @objc func shareTapped() {

    }
    
    
    func createButton(withImageName imageName: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        return button
    }
}
