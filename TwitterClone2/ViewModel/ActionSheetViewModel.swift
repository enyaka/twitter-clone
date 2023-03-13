//
//  ActionSheetViewModel.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 13.03.2023.
//

import Foundation

struct ActionSheetViewModel {
    
    private let user : User
    
    var options : [ActionSheetOptions] {
        var results = [ActionSheetOptions]()
        if user.isCurrentUser {
            results.append(.delete)
        } else {
            let followOption : ActionSheetOptions = user.isFollowed ? .unfollow(user) : .follow(user)
            results.append(followOption)
            results.append(.report)
            results.append(.block)
        }
        
        return results
    }
    
    init(user: User) {
        self.user = user
    }
    
}

enum ActionSheetOptions {
    case follow(User)
    case unfollow(User)
    case report
    case delete
    case block
    
    var description : String {
        switch self {
        case .follow(let user): return "Follow @\(user.username)"
        case .unfollow(let user): return "Unfollow @\(user.username)"
        case .report: return "Report Tweet"
        case .delete: return "Delete Tweet"
        case .block: return "Block User"
        }
    }
}
