//
//  TweetCell.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 5.03.2023.
//

import UIKit

class TweetCell: UICollectionViewCell {
    private let profileImageView : UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.setDimensions(width: 48, height: 48)
        image.layer.cornerRadius = 48 / 2
        image.backgroundColor = .twitterBlue
        return image
    }()
    
    private let captionLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.text = "Lorem ipsum blabla"
        return label
    }()
    
    private let infoLabel = UILabel()
    
    private lazy var commentButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "comment"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(commentTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var retweetButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "retweet"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(commentTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var likeButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "like"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(commentTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var shareButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "comment"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(commentTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
        let stack = UIStackView(arrangedSubviews: [infoLabel, captionLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 12
        
        addSubview(stack)
        stack.anchor(top: profileImageView.topAnchor, left: profileImageView.rightAnchor, right: rightAnchor, paddingLeft: 12, paddingRight: 12)
        infoLabel.font = UIFont.systemFont(ofSize: 14)
        infoLabel.text = "Test test @test"
        
        let actionStack = UIStackView(arrangedSubviews: [commentButton, retweetButton, likeButton, shareButton])
        actionStack.axis = .horizontal
        actionStack.spacing = 72
        
        addSubview(actionStack)
        actionStack.centerX(inView: self)
        actionStack.anchor(bottom: bottomAnchor, paddingBottom: 8)
        
        let underLine = UIView()
        underLine.backgroundColor = .systemGroupedBackground
        addSubview(underLine)
        underLine.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 0.75)

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func commentTapped() {
        print("dsadas")
    }
    
    @objc func retweetTapped() {
        print("dsadas")

    }
    
    @objc func likeTapped() {
        print("dsadas")

    }
    
    @objc func shareTapped() {
        print("dsadas")

    }
}