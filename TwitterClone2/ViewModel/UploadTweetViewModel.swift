//
//  UploadTweetViewModel.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 12.03.2023.
//

import UIKit

enum UploadTweetConfiguration {
    case tweet
    case retweet(Tweet)
}

struct UploadTweetViewModel {
    let actionButtonTitle : String
    let placeholderText : String
    var shouldShowReplyLabel : Bool
    var replyText : String?
    
    init(config: UploadTweetConfiguration) {
        switch config {
        case .tweet:
            actionButtonTitle = "Tweet"
            placeholderText = "What's happening?"
            shouldShowReplyLabel = false
        case.retweet(let tweet):
            actionButtonTitle = "Reply"
            placeholderText = "Tweet your reply"
            shouldShowReplyLabel = true
            replyText = "Replying to @\(tweet.user.username)"
        }
    }
}
