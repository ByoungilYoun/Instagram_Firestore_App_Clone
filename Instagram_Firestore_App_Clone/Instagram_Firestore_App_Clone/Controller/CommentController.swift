//
//  CommentController.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/05/16.
//

import UIKit

class CommentController : UICollectionViewController  {
  
  //MARK: - Properties
  
  //MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
  }
  
  //MARK: - Functions
  
  private func configureCollectionView() {
    navigationItem.title = "Comments"
    collectionView.backgroundColor = .white
    collectionView.register(CommentCell.self, forCellWithReuseIdentifier: CommentCell.identifier)
    
  }
}

  //MARK: - UICollectionViewDataSource
extension CommentController {
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 5
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentCell.identifier, for: indexPath) as! CommentCell
    cell.backgroundColor = .red
    return cell
  }
}

  //MARK: - UICollectionViewDelegateFlowLayout
extension CommentController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 80)
  }
  
  
}
