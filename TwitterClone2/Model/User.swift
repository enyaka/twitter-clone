//
//  User.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 5.03.2023.
//

import Firebase

struct User {
    let uid : String
    var fullname : String
    let email : String
    var username : String
    var profileImageUrl : URL?
    var isFollowed : Bool = false
    var stats : UserRelationStats?
    var bio : String?
    
    var isCurrentUser : Bool {
        return Auth.auth().currentUser?.uid == uid
    }
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.bio = dictionary["bio"] as? String ?? ""
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
