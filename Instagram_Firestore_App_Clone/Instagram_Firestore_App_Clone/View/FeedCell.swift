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
  
  var viewModel : PostViewModel? {
    didSet {
      configure()
    }
  }
  
  private let profileImageView : UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.isUserInteractionEnabled = true
    iv.backgroundColor = .lightGray
    return iv
  }()
  
  private lazy var userNameButton : UIButton = {
    let button = UIButton(type: .system)
    button.setTitleColor(.black, for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
    button.addTarget(self, action: #selector(didTapUsername), for: .touchUpInside)
    return button
  }()
  
  private let postImageView : UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.isUserInteractionEnabled = true
    iv.image = #imageLiteral(resourceName: "venom-7")
    return iv
  }()
  
  private lazy var likeButton : UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "like_unselected"), for: .normal)
    button.tintColor = .black
    return button
  }()
  
  private lazy var commentButton : UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "comment"), for: .normal)
    button.tintColor = .black
    return button
  }()
  
  private lazy var shareButton : UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "send2"), for: .normal)
    button.tintColor = .black
    return button
  }()
  
  private let likesLabel : UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 13)
    label.textColor = .black
    return label
  }()
  
  private let captionLabel : UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14)
    label.textColor = .black
    return label
  }()
  
  private let postTimeLabel : UILabel = {
    let label = UILabel()
    label.text = "2 days ago"
    label.font = UIFont.systemFont(ofSize: 12)
    label.textColor = .lightGray
    return label
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
    
    [profileImageView, userNameButton, postImageView, likesLabel, captionLabel, postTimeLabel].forEach {
      addSubview($0)
    }
    
    profileImageView.snp.makeConstraints {
      $0.top.leading.equalToSuperview().offset(12)
      $0.height.width.equalTo(40)
    }
    profileImageView.layer.cornerRadius = 40 / 2 // profileImageView 둥글게 하기
    
    userNameButton.snp.makeConstraints {
      $0.centerY.equalTo(profileImageView)
      $0.leading.equalTo(profileImageView.snp.trailing).offset(8)
    }
    
    postImageView.snp.makeConstraints {
      $0.top.equalTo(profileImageView.snp.bottom).offset(8)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(self.snp.width).multipliedBy(1)
    }
    
    configureActionButton() // postImageView 에 대한 constraint 속성을 다 해주고 해줘야 한다. (주의)
    
    likesLabel.snp.makeConstraints {
      $0.top.equalTo(likeButton.snp.bottom).offset(4)
      $0.leading.equalToSuperview().offset(8)
    }
    
    captionLabel.snp.makeConstraints {
      $0.top.equalTo(likesLabel.snp.bottom).offset(8)
      $0.leading.equalToSuperview().offset(8)
    }
    
    postTimeLabel.snp.makeConstraints {
      $0.top.equalTo(captionLabel.snp.bottom).offset(8)
      $0.leading.equalToSuperview().offset(8)
    }
  }
  
  // 스택뷰에 하트 버튼, 커멘트 버튼, share버튼 올려서 나타내주는 함수
  func configureActionButton() {
    let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton, shareButton])
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    
    addSubview(stackView)
    stackView.snp.makeConstraints {
      $0.top.equalTo(postImageView.snp.bottom)
      $0.width.equalTo(120)
      $0.height.equalTo(50)
    }
  }
  
  func configure() {
    guard let viewModel = viewModel else {return}
    captionLabel.text = viewModel.caption
    postImageView.sd_setImage(with: viewModel.imageUrl)
    likesLabel.text = viewModel.likesLabelText
    
    profileImageView.sd_setImage(with: viewModel.userProfileImageUrl)
    userNameButton.setTitle(viewModel.username, for: .normal)
  }
  
  //MARK: - objc func
  @objc func didTapUsername() {
    print("Debug : did tap username")
  }
}
