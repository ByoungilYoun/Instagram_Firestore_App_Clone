//
//  FeedCell.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/03/21.
//

import UIKit

class FeedCell : UICollectionViewCell {
  
  static let identifier = "FeedCell"
  
  //MARK: - Properties
  private let profileImageView : UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.isUserInteractionEnabled = true
    iv.image = #imageLiteral(resourceName: "venom-7")
    return iv
  }()
  
  private lazy var userNameButton : UIButton = {
    let button = UIButton(type: .system)
    button.setTitleColor(.black, for: .normal)
    button.setTitle("venom", for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
    button.addTarget(self, action: #selector(didTapUsername), for: .touchUpInside)
    return button
  }()
  
  //MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
  private func configureUI () {
    backgroundColor = .white
    
    [profileImageView, userNameButton].forEach {
      addSubview($0)
    }
    
    profileImageView.snp.makeConstraints {
      $0.top.leading.equalToSuperview().inset(12) // inset 기준이 x,y 의 시작점
      $0.height.width.equalTo(40)
    }
    profileImageView.layer.cornerRadius = 40 / 2
    
    userNameButton.snp.makeConstraints {
      $0.centerY.equalTo(profileImageView)
      $0.leading.equalTo(profileImageView.snp.trailing).inset(-8)
    }
  }
  
  //MARK: - objc func
  @objc func didTapUsername() {
    print("Debug : did tap username")
  }
}
