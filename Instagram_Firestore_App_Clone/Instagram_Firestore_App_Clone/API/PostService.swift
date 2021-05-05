//
//  PostService.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/05/05.
//

import UIKit
import Firebase

struct PostService {
  
  static func uploadPost(caption : String, image : UIImage, completion : @escaping(FirestoreCompletion)) {
    guard let uid = Auth.auth().currentUser?.uid else {return}
    
    ImageUploader.uploadImage(image: image) { imageUrl in
      let data = ["caption" : caption, "timestamp" : Timestamp(date: Date()), "likes" : 0, "imageUrl" : imageUrl, "ownerUid" : uid ] as [String : Any]
      COLLECTION_POSTS.addDocument(data: data, completion: completion)
      
    }
  }
}
