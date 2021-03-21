//
//  FeedController.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/03/21.
//

import UIKit

class FeedController : UICollectionViewController {
  
  //MARK: - Properties
  
  //MARK: - Lifecycle 
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  //MARK: - Helpers
  func configureUI() {
    collectionView.backgroundColor = .white
    collectionView.register(FeedCell.self, forCellWithReuseIdentifier: FeedCell.identifier)
  }
}

  //MARK: - UICollectionViewDataSource
extension FeedController {
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
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