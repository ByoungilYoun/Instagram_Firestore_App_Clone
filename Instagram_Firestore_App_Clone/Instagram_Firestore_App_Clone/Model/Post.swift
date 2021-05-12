//
//  Post.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/05/12.
//

import Firebase

struct Post {
  let caption : String
  var likes : Int
  let imageUrl : String
  let ownerUid : String
  let timestamp : Timestamp
  let postId : String
  
  init(postId : String ,dictionary : [String : Any]) {
    self.caption = dictionary["caption"] as? String ?? ""
    self.likes = dictionary["likes"] as? Int ?? 0
    self.imageUrl = dictionary["imageUrl"] as? String ?? ""
    self.ownerUid = dictionary["ownerUid"] as? String ?? ""
    self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
    self.postId = postId
  }
}


