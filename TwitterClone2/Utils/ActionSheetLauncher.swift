//
//  ActionSheetLauncher.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 12.03.2023.
//

import UIKit

final class ActionSheetLauncher: NSObject {
    
    private let user : User
    
    init(user: User) {
        self.user = user
        super.init()
    }
    
    
    func show() {
        print("DEBUG: Show action sheet \(user.username)")
    }
    
}
