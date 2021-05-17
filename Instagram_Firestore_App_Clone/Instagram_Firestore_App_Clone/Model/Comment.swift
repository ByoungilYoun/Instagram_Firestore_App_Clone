//
//  Comment.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/05/18.
//

import Firebase

struct Comment {
  let uid : String
  let username : String
  let profileImageUrl : String
  let timestamp : Timestamp
  let commentText : String
  
  init(dictionary : [String : Any]) {
    self.uid = dictionary["uid"] as? String ?? ""
    self.username = dictionary["username"] as? String ?? ""
    self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    self.commentText = dictionary["comment"] as? String ?? ""
    self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date : Date())
  }
}
