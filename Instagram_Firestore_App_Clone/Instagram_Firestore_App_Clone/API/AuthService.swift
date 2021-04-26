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
  
  static func logUserIn(withEmail email : String, password : String, completion : (AuthDataResultCallback?)) {
    Auth.auth().signIn(withEmail: email, password: password, completion: completion)
  }
  
  static func registerUser(withCredentials credentials : AuthCredentials, completion : @escaping(Error?) -> Void) {
    
    // 1. 이미지 업로드 먼저 하기
    ImageUploader.uploadImage(image: credentials.profileImage) { imageUrl in
      Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
        if let error = error {
          print("Debug : Failed to register user \(error.localizedDescription)/")
          return
        }
        
        // uid = unique identifier
        guard let uid = result?.user.uid else {return}
        
        let data : [String : Any] = ["email" : credentials.email,
                                     "fullname" : credentials.fullname,
                                     "profileImageUrl" : imageUrl,
                                     "username" : credentials.username,
                                     "uid" : uid]
       COLLECTION_USERS.document(uid).setData(data, completion: completion)
      }
    }
  }
}
