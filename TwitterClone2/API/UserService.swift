//
//  UserService.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 5.03.2023.
//

import Firebase

struct UserSevice {
    static let shared = UserSevice()
    
    func fetchUser(uid: String, completion: @escaping(User) -> Void) {
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String: AnyObject] else {return}
            let user = User(uid: uid, dictionary: dictionary)
            completion(user)
            
        }
    }
    
    func fetchUsers(completion: @escaping([User]) -> Void) {
        var users = [User]()
        REF_USERS.observe(.childAdded) { snapshot in
            guard let dictionary = snapshot.value as? [String : AnyObject] else {return}
            let uid = snapshot.key
            let user = User(uid: uid, dictionary: dictionary)
            users.append(user)
            completion(users)
        }
    }
}
