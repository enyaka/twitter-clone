//
//  User.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 5.03.2023.
//

import Firebase

struct User {
    let uid : String
    let fullname : String
    let email : String
    let username : String
    var profileImageUrl : URL?
    var isFollowed : Bool = false
    var stats : UserRelationStats?
    
    var isCurrentUser : Bool {
        return Auth.auth().currentUser?.uid == uid
    }
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        if let profileImageUrlString = dictionary["profileImageUrl"] as? String {
            guard let url = URL(string: profileImageUrlString) else {return}
            self.profileImageUrl = url
        }

    }
}

struct UserRelationStats {
    var followers : Int
    var following : Int
}
