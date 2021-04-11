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
  
  private let postImageView : UIImageView = {
    let iv = UIImageView()
    iv.image = #imageLiteral(resourceName: "venom-7")
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    return iv
  }()
  
  //MARK: - Lifecycle
  
  override init(frame : CGRect) {
    super.init(frame : frame)
    backgroundColor = .lightGray
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Funtion
  private func configureUI() {
    addSubview(postImageView)
    
    postImageView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
  }
}
