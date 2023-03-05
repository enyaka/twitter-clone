//
//  Constants.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 4.03.2023.
//

import Firebase
import FirebaseStorage

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
let REF_TWEETS = DB_REF.child("tweets")

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")


