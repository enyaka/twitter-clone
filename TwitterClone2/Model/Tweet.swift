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
    var likes : Int
    var timestamp : Date!
    let retweetCount : Int
    let user : User
    var didLike : Bool = false
    
    init(user: User, tweetID : String, dictionary: [String:Any]) {
        self.user = user
        self.tweetID = tweetID
        self.caption = dictionary["caption"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.retweetCount = dictionary["retweetCount"] as? Int ?? 0
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }

    }
}
