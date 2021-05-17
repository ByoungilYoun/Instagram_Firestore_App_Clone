//
//  CommentController.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/05/16.
//

import UIKit

class CommentController : UICollectionViewController  {
  
  //MARK: - Properties
  
  private let post : Post
  
  private var comments = [Comment]()
  
  private lazy var commentInputView : CommentInputAccessoryView = {
    let frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50)
    let cv = CommentInputAccessoryView(frame: frame)
    cv.delegate = self
    return cv
  }()
  //MARK: - Lifecycle
  
  init(post : Post) {
    self.post = post
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
    fetchComments()
  }
  
  override var inputAccessoryView: UIView? {
    get {
      return commentInputView
    }
  }
  
  override var canBecomeFirstResponder: Bool {
    return true
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tabBarController?.tabBar.isHidden = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    tabBarController?.tabBar.isHidden = false
  }
  
  //MARK: - Functions
  
  private func configureCollectionView() {
    navigationItem.title = "Comments"
    collectionView.backgroundColor = .white
    collectionView.register(CommentCell.self, forCellWithReuseIdentifier: CommentCell.identifier)
    collectionView.alwaysBounceVertical = true // 스크롤 하면 키보드 내려가게 하는 기능
    collectionView.keyboardDismissMode = .interactive // 스크롤 하면 키보드 내려가게 하는 기능
  }
  
  func fetchComments() {
    CommentService.fetchComments(postID: post.postId) { comments in
      self.comments = comments
      self.collectionView.reloadData()
    }
  }
}

  //MARK: - UICollectionViewDataSource
extension CommentController {
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return comments.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentCell.identifier, for: indexPath) as! CommentCell
    return cell
  }
}

  //MARK: - UICollectionViewDelegateFlowLayout
extension CommentController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 80)
  }
}

  //MARK: - CommentInputAccessoryViewDelegate
extension CommentController : CommentInputAccessoryViewDelegate {
  func inputView(_ inputView: CommentInputAccessoryView, wantsToUploadComment comment: String) {

    guard let tab = self.tabBarController as? MainTabController else {return}
    guard let user = tab.user else {return}
    
    self.showLoader(true)
    
    CommentService.uploadComment(comment: comment, postID: post.postId, user: user) { error in
      self.showLoader(false)
      inputView.clearCommentTextView()
    }
  }
}
