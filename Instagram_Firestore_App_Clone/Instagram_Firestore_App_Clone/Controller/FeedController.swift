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
  
  var post : Post?
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
    
    if post == nil {
      navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    }
    navigationItem.title = "Feed"
    
    let refresher = UIRefreshControl()
    refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    collectionView.refreshControl = refresher
  }
  
  //MARK: - API
  
  func fetchPosts() {
    guard post == nil else {return}
    
    PostService.fetchPosts { posts in
      self.posts = posts
      self.collectionView.refreshControl?.endRefreshing()
      self.collectionView.reloadData()
    }
  }
  
  //MARK: - Actions
  
  @objc func handleRefresh() {
    posts.removeAll()
    fetchPosts()
  }
  
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
    return post == nil ? posts.count : 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCell.identifier, for: indexPath) as! FeedCell
    cell.delegate = self
    if let post = post {
      cell.viewModel = PostViewModel(post: post)
    } else {
      cell.viewModel = PostViewModel(post: posts[indexPath.row])
    }
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
  //MARK: - FeedCellDelegate
extension FeedController : FeedCellDelegate {
  func cell(_ cell: FeedCell, wantsToShowCommentsFor post: Post) {
    let controller = CommentController(post: post)
    navigationController?.pushViewController(controller, animated: true)
  }
}
