//
//  CommentCell.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/05/16.
//

import UIKit

class CommentCell : UICollectionViewCell {
  
  static let identifier = "CommentCell"
  
  //MARK: - Properties
  
  var viewModel : CommentViewModel? {
    didSet {
      configure()
    }
  }
  
  private let profileImageView : UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.backgroundColor = .lightGray
    return iv
  }()
  
  private let commentLabel : UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.numberOfLines = 0
    return label
  }()

  //MARK: - Lifecycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
  private func setUI() {
    [profileImageView, commentLabel].forEach {
      addSubview($0)
    }
    
    profileImageView.snp.makeConstraints {
      $0.top.equalTo(self.snp.top).offset(5)
      $0.leading.equalTo(self.snp.leading).offset(8)
      $0.width.height.equalTo(40)
    }
    profileImageView.layer.cornerRadius = 40 / 2
    
    commentLabel.snp.makeConstraints {
      $0.centerY.equalTo(profileImageView.snp.centerY)
      $0.leading.equalTo(profileImageView.snp.trailing).offset(8)
      $0.trailing.equalTo(self.snp.trailing).offset(-8)
    }
  }
  
  func configure() {
    guard let viewModel = viewModel else {return}
    
    profileImageView.sd_setImage(with: viewModel.profileImageUrl)
    commentLabel.attributedText = viewModel.commentLabelText()
  }
}
