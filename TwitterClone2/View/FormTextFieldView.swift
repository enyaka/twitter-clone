//
//  FormFieldView.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 1.03.2023.
//

import UIKit

class FormTextFieldView : UIView {
    let textField : UITextField = {
        let field = UITextField()
        field.leftViewMode = .always
        field.tintColor = .white
        field.font = UIFont.systemFont(ofSize: 16)
        field.textColor = .white
        
        return field
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        let divider = UIView()
        divider.backgroundColor = .white
        addSubview(textField)
        addSubview(divider)
        anchor(height: 50)
        textField.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
        divider.anchor(top: textField.bottomAnchor,left: leftAnchor,right: rightAnchor,paddingTop: 10,height: 0.75)
    }
}
