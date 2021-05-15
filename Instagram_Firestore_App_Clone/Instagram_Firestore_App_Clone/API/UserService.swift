//
//  UserService.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/04/18.
//

import Firebase

typealias FirestoreCompletion = (Error?) -> Void

struct UserService {
  
  // 유저 한명 가져오는 함수
  static func fetchUser(completion : @escaping(User) -> Void) {
    guard let uid = Auth.auth().currentUser?.uid else {return}
    COLLECTION_USERS.document(uid).getDocument { snapshot, error in
      guard let dictionary = snapshot?.data() else {return}
      
      let user = User(dictionary: dictionary)
      completion(user)
    }
  }
  
  // 모든 유저 가져오는 함수
  static func fetchUsers(completion : @escaping([User]) -> Void) {
    COLLECTION_USERS.getDocuments { (snapshot, error) in
      guard let snapshot = snapshot else {return}
      
      let users = snapshot.documents.map( {User(dictionary: $0.data())}) //document 의 data 를 map 해준다.
      completion(users)
    }
  }
  
  // follow 할때 요청하는 함수
  static func follow(uid : String, completion : @escaping (FirestoreCompletion)) {
    guard let currentUid = Auth.auth().currentUser?.uid else {return}
    COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).setData([:]) { error in
      COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).setData([:], completion: completion)
    }
  }
  
  // unfollow 할때 요청하는 함수
  static func unfollow(uid : String, completion : @escaping (FirestoreCompletion)){
    guard let currentUid = Auth.auth().currentUser?.uid else {return}
    COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).delete { error in
      COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).delete(completion: completion)
    }
  }
  
  // 팔로잉 하고있는지 안하고있는지 확인하는 함수
   static func checkIfUserIsFollowed(uid : String, completion : @escaping(Bool) -> Void) {
    guard let currentUid = Auth.auth().currentUser?.uid else {return}
    
    COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).getDocument { snapshot, error in
      guard let isFollowed = snapshot?.exists else {return}
      completion(isFollowed)
    }
  }
  
  // 팔로잉이랑 팔로워 명수 가져오는 함수 
  static func fetchUserStats(uid : String, completion : @escaping(UserStats) -> Void) {
    COLLECTION_FOLLOWERS.document(uid).collection("user-followers").getDocuments { (snapshot, _) in
      let followers = snapshot?.documents.count ?? 0
      
      COLLECTION_FOLLOWING.document(uid).collection("user-following").getDocuments { (snapshot, _) in
        let following = snapshot?.documents.count ?? 0
        
        COLLECTION_POSTS.whereField("ownerUid", isEqualTo: uid).getDocuments { snapshot, _ in
          let posts = snapshot?.documents.count ?? 0
          completion(UserStats(followers: followers, following: following, posts: posts))
        }
      }
    }
  }
}
