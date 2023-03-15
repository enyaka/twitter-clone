//
//  NotificationService.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 14.03.2023.
//

import Firebase

struct NotificationService {
    static let shared = NotificationService()
    
    func uploadNotification(type: NotificationType, tweet: Tweet? = nil, user: User? = nil) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        var values: [String: Any] = ["timestamp": Int(NSDate().timeIntervalSince1970),
                                     "uid": uid, "type" : type.rawValue
        ]
        
        if let tweet = tweet {
            values["tweetID"] = tweet.tweetID
            REF_NOTIFICATIONS.child(tweet.user.uid).childByAutoId().updateChildValues(values)
        } else if let user = user {
            REF_NOTIFICATIONS.child(user.uid).childByAutoId().updateChildValues(values)
        }
    }
    
    func fetchNotifications(completion: @escaping([Notification]) -> Void) {
        var notifications = [Notification]()
        guard let uid = Auth.auth().currentUser?.uid else {return}
        REF_NOTIFICATIONS.child(uid).observe(.childAdded) { snap in
            guard let dictionary = snap.value as? [String: AnyObject] else {return}
            guard let tweetUid = dictionary["uid"] as? String else {return}
            
            UserSevice.shared.fetchUser(uid: tweetUid) { user in
                let notification = Notification(user: user, dictionary: dictionary)
                notifications.append(notification)
                completion(notifications)
            }

        }
    }
}
