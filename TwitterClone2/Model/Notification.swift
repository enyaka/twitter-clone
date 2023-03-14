//
//  Notification.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 14.03.2023.
//

import Foundation

enum NotificationType : Int {
    case follow
    case like
    case reply
    case retweet
    case mention
}

struct Notification {
    var timestamp : Date!
    let user: User
    let tweetID: String?
    var tweet: Tweet?
    var type: NotificationType!
    
    init(user: User, tweet: Tweet?, dictionary: [String: AnyObject]) {
        self.user = user
        self.tweet = tweet
        self.tweetID = dictionary["uid"] as? String ?? ""
        
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
        if let type = dictionary["type"] as? Int {
            self.type = NotificationType(rawValue: type)
        }
    }
}
