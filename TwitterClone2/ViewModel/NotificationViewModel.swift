//
//  NotificationViewModel.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 14.03.2023.
//

import UIKit

struct NotificationViewModel {
    
    private let notification: Notification
    private let type: NotificationType
    private let user: User
    
    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let now = Date()
        return formatter.string(from: notification.timestamp, to: now) ?? "0s"
    }
    var notificationMessage : String {
        switch type {
        case .follow: return "started following you"
        case .like: return "liked your tweet"
        case .reply: return "replied to your tweet"
        case .retweet: return "retweet your tweet"
        case .mention: return "metioned you in a tweet"
        }
    }
    
    var notificationText : NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "\(user.fullname) ", attributes: [.font: UIFont.boldSystemFont(ofSize: 12)])
        
        attributedText.append(NSAttributedString(string: notificationMessage, attributes: [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.lightGray]))
        
        attributedText.append(NSAttributedString(string: " · \(timestampString) ", attributes: [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.lightGray]))
        
        
        return attributedText
    }
    
    var profileImageUrl: URL? {
        return user.profileImageUrl
    }
    
    init(notification: Notification){
        self.notification = notification
        self.type = notification.type
        self.user = notification.user
    }
    
}
