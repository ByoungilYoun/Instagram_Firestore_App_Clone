//
//  AuthService.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/04/03.
//

import UIKit
import Firebase

struct AuthCredentials {
  let email : String
  let password : String
  let fullname : String
  let username : String
  let profileImage : UIImage
}

struct AuthService {
  
  static func registerUser(withCredentials credentials : AuthCredentials) {
    print("Debug : Credentials are : \(credentials)")
  }
}
