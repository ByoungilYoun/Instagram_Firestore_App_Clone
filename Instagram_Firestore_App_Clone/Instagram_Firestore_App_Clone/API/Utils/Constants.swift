//
//  Constants.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/04/18.
//

import Firebase

let COLLECTION_USERS = Firestore.firestore().collection("users") 
let COLLECTION_FOLLOWERS = Firestore.firestore().collection("followers")
let COLLECTION_FOLLOWING = Firestore.firestore().collection("following")
let COLLECTION_POSTS = Firestore.firestore().collection("posts")
