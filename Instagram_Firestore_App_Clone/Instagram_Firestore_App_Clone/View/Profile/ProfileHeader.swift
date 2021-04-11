//
//  ProfileHeader.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/04/11.
//

import UIKit

class ProfileHeader : UICollectionReusableView {
  
  //MARK: - Properties
  static let identifier = "ProfileHeader"
  
  //MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemPink
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
