//
//  UserCellViewModel.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/04/25.
//

import Foundation

struct UserCellViewModel {
  
  private let user : User
  
  init(user : User) {
    self.user = user
  }
  
  var profileImageUrl : URL? {
    return URL(string: user.profileImageUrl)
  }
  
  var username : String {
    return user.username
  }
  
  var fullname : String {
    return user.fullname
  }
}
