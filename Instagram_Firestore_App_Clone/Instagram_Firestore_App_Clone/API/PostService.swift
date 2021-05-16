//
//  PostService.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/05/05.
//

import UIKit
import Firebase

struct PostService {
  
  static func uploadPost(caption : String, image : UIImage, user : User, completion : @escaping(FirestoreCompletion)) {
    guard let uid = Auth.auth().currentUser?.uid else {return}
    
    ImageUploader.uploadImage(image: image) { imageUrl in
      let data = ["caption" : caption, "timestamp" : Timestamp(date: Date()), "likes" : 0, "imageUrl" : imageUrl, "ownerUid" : uid, "ownerImageUrl" : user.profileImageUrl, "ownerUsername" : user.username ] as [String : Any]
      COLLECTION_POSTS.addDocument(data: data, completion: completion)
      
    }
  }
  
  static func fetchPosts(completion : @escaping([Post]) -> Void) {
    COLLECTION_POSTS.order(by: "timestamp", descending: true).getDocuments { snapshot, error in
      guard let documents = snapshot?.documents else {return}
      
      let post = documents.map({ Post(postId: $0.documentID, dictionary: $0.data())})
      completion(post)
    }
  }
  
  static func fetchPosts(forUser uid : String, completion : @escaping([Post]) -> Void) {
    let query = COLLECTION_POSTS.whereField("ownerUid", isEqualTo: uid)
    
    query.getDocuments { snapshot, error in
      guard let documents = snapshot?.documents else {return}
      
      var post = documents.map({ Post(postId: $0.documentID, dictionary: $0.data())})
      
      post.sort { (post1, post2) -> Bool in
        return post1.timestamp.seconds > post2.timestamp.seconds
      }
      
      completion(post)
    }
  }
}
