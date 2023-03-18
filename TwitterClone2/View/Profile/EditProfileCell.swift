//
//  EditProfileCell.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 18.03.2023.
//

import UIKit

final class EditProfileCell : UITableViewCell {
    
    var viewModel: EditProfileViewModel? {
        didSet { configure() }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var infoTextField : UITextField = {
        let field = UITextField()
        field.borderStyle = .none
        field.font = UIFont.systemFont(ofSize: 14)
        field.textAlignment = .left
        field.textColor = .twitterBlue
        field.addTarget(self, action: #selector(handleUpdateUserInfo), for: .editingDidEnd)
        return field
    }()
    
    let bioTextView : InputTextView = {
        let bio = InputTextView()
        bio.font = UIFont.systemFont(ofSize: 14)
        bio.textColor = .twitterBlue
        bio.placeholderLabel.text = "Bio"
        return bio
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        addSubview(titleLabel)
//        titleLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        titleLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 16,width: 100)
        
        addSubview(infoTextField)
        infoTextField.anchor(top: topAnchor, left: titleLabel.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 16, paddingRight: 8)
        
        addSubview(bioTextView)
        infoTextField.anchor(top: topAnchor, left: titleLabel.rightAnchor,bottom: bottomAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 16, paddingRight: 8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        guard let viewModel = viewModel else {return}
        infoTextField.isHidden = viewModel.shouldHideTextField
        bioTextView.isHidden = viewModel.shouldHideTextView
        titleLabel.text = viewModel.titleText
        infoTextField.text = viewModel.optionValue
        bioTextView.text = viewModel.optionValue
    }
    
    @objc func handleUpdateUserInfo() {
        
    }
    
}
