//
//  Tweet.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 5.03.2023.
//

import Foundation

struct Tweet {
    let caption : String
    let tweetID : String
    let uid : String
    let likes : Int
    var timestamp : Date!
    let retweetCount : Int
    let user : User
    
    init(user: User, tweetID : String, dictionary: [String:Any]) {
        self.user = user
        self.tweetID = tweetID
        self.caption = dictionary["caption"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.retweetCount = dictionary["retweetCount"] as? Int ?? 0
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }

    }
}
