//
//  ProfileHeaderViewModel.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/04/18.
//

import UIKit

struct ProfileHeaderViewModel {
  let user : User
  
  var fullname : String {
    return user.fullname
  }
  
  var profileImageUrl : URL? {
    return URL(string: user.profileImageUrl)
  }
  
  var followButtonText : String {
    if user.isCurrentUser {
      return "Edit Profile"
    }
      return user.isFollowed ? "Following" : "Follow"
  }
  
  var followButtonBackgroundColor : UIColor {
    return user.isCurrentUser ? .white : .systemBlue
  }
  
  var followButtonTextColor : UIColor {
    return user.isCurrentUser ? .black : .white
  }
  
  init (user : User ) {
    self.user = user
  }
}
