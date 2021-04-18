//
//  ProfileHeaderViewModel.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/04/18.
//

import Foundation

struct ProfileHeaderViewModel {
  let user : User
  
  var fullname : String {
    return user.fullname
  }
  
  var profileImageUrl : URL? {
    return URL(string: user.profileImageUrl)
  }
  
  init (user : User ) {
    self.user = user
  }
}
