//
//  ProfileHeadeViewModel.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 7.03.2023.
//

import Foundation

enum ProfileFilterOptions: Int, CaseIterable {
    case tweets
    case replies
    case likes
    
    var description : String {
        switch self {
        case .tweets: return "Tweets"
        case .replies: return "Tweets & Replies"
        case .likes: return "Likes"
        }
    }
}
