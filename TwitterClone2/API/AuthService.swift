//
//  AuthService.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 4.03.2023.
//

import Firebase
import UIKit
import FirebaseStorage

struct AuthCredentials {
    let email : String
    let password : String
    let fullname : String
    let username : String
    let profileImage : UIImage
}

struct AuthService {
    static let shared = AuthService()
    
    func registerUser(credentials: AuthCredentials, completion: @escaping(Error?, DatabaseReference) -> Void) {
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let storageRef = STORAGE_PROFILE_IMAGES.child(filename)
        storageRef.putData(imageData, metadata: nil) { meta, error in
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
                return
            }
            storageRef.downloadURL { url, error in
                if let error = error {
                    print("DEBUG: \(error.localizedDescription)")
                    return
                }
                guard let profileImageUrl = url?.absoluteString else { return }

                Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
                    if let error = error {
                        print("ERROR: \(error.localizedDescription)")
                        return
                    }
                    print("DEBUG: User succesfuly created")
                    guard let uid = result?.user.uid else { return }
                    let values = ["email": credentials.email, "username": credentials.username, "fullname": credentials.fullname, "profileImageUrl": profileImageUrl]
                    
                    REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
                }

            }
        }
    }
}
