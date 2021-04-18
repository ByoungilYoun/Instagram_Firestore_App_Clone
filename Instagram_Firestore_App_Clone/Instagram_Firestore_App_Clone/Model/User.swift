//
//  User.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/04/18.
//

import Foundation

struct User {
  let email : String
  let fullname : String
  let profileImageUrl : String
  let username : String
  let uid : String
  
  init(dictionary : [String : Any]) {
    self.email = dictionary["email"] as? String ?? ""
    self.fullname = dictionary["fullname"] as? String ?? ""
    self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    self.username = dictionary["username"] as? String ?? ""
    self.uid = dictionary["uid"] as? String ?? ""
  }
}
