//
//  ProfileCell.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/04/11.
//

import UIKit

class ProfileCell : UICollectionViewCell {
  
  //MARK: - Properties
  static let identifier = "ProfileCell"
  //MARK: - Lifecycle
  
  override init(frame : CGRect) {
    super.init(frame : frame)
    backgroundColor = .lightGray
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
