//
//  UserCell.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/04/25.
//

import UIKit

class UserCell : UITableViewCell {
  
  //MARK: - Properties
  static let identifier = "UserCell"
  
  // 사용자 프로파일 동그란 이미지 뷰
  private let profileImageView : UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.backgroundColor = .lightGray
    iv.image = #imageLiteral(resourceName: "venom-7")
    return iv
  }()
  
  // 유저네임 라벨
  private let usernameLabel : UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.text = "venom"
    return label
  }()
  
  // 유저 풀네임 라벨
  private let fullnameLabel : UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16)
    label.text = "Eddie Brock"
    label.textColor = .lightGray
    return label
  }()
  
  //MARK: - Lifecycle
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Function
  private func configureUI() {
    [profileImageView].forEach {
      addSubview($0)
    }
    profileImageView.layer.cornerRadius = 48 / 2
    
    profileImageView.snp.makeConstraints {
      $0.width.height.equalTo(48)
      $0.centerY.equalTo(self.snp.centerY)
      $0.leading.equalTo(self.snp.leading).offset(12)
    }
    
    let stack = UIStackView(arrangedSubviews: [usernameLabel, fullnameLabel])
    stack.axis = .vertical
    stack.spacing = 4
    stack.alignment = .leading
    
    addSubview(stack)
    stack.snp.makeConstraints {
      $0.leading.equalTo(profileImageView.snp.trailing).offset(8)
      $0.centerY.equalTo(self.snp.centerY)
    }
  }
}
