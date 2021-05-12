//
//  FeedController.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/03/21.
//

import UIKit
import Firebase

class FeedController : UICollectionViewController {
  
  //MARK: - Properties
  
  private var posts = [Post]()
  
  //MARK: - Lifecycle 
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    fetchPosts()
  }
  
  //MARK: - Helpers
  func configureUI() {
    collectionView.backgroundColor = .white
    collectionView.register(FeedCell.self, forCellWithReuseIdentifier: FeedCell.identifier)
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    navigationItem.title = "Feed"
  }
  
  //MARK: - API
  
  func fetchPosts() {
    PostService.fetchPosts { posts in
      self.posts = posts
      self.collectionView.reloadData()
    }
  }
  
  //MARK: - Actions
  @objc func handleLogout() {
    do {
      try Auth.auth().signOut()
    
      let controller = LoginController()
      controller.delegate = self.tabBarController as? MainTabController
      let navi = UINavigationController(rootViewController: controller)
      navi.modalPresentationStyle = .fullScreen
      self.present(navi, animated: true, completion: nil)
    } catch {
      print("Debug : Failed to sign out")
    }
  }
}

//MARK: - UICollectionViewDataSource
extension FeedController {
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return posts.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCell.identifier, for: indexPath) as! FeedCell
    return cell
  }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension FeedController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let width = view.frame.width
    var height = width + 8 + 40 + 8
    height += 50
    height += 60
    return CGSize(width: width, height: height)
  }
}
