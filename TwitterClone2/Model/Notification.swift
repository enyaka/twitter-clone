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
    var user: User
    var tweetID: String?
    var type: NotificationType!
    
    init(user: User, dictionary: [String: AnyObject]) {
        self.user = user
        if let tweetID = dictionary["tweetID"] as? String {
            self.tweetID = tweetID
        }
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
        if let type = dictionary["type"] as? Int {
            self.type = NotificationType(rawValue: type)
        }
    }
}
