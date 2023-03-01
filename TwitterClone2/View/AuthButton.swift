//
//  AuthButton.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 1.03.2023.
//

import UIKit

final class AuthButton : UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String) {
        self.init(frame: .zero)
        setTitle(title, for: .normal)
    }
    
    func configureUI() {
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        setTitleColor(.twitterBlue, for: .normal)
        backgroundColor = .white
        layer.cornerRadius = 5
        anchor(height: 50)
    }
}
