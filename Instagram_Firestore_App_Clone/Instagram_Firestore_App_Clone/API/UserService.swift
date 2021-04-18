//
//  UserService.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/04/18.
//

import Firebase

struct UserService {
  static func fetchUser(completion : @escaping(User) -> Void) {
    guard let uid = Auth.auth().currentUser?.uid else {return}
    COLLECTION_USERS.document(uid).getDocument { snapshot, error in
      guard let dictionary = snapshot?.data() else {return}
      
      let user = User(dictionary: dictionary)
      completion(user)
    }
  }
}