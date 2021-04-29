//
//  ProfileHeader.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/04/11.
//

import UIKit
import SDWebImage

protocol ProfileHeaderDelegate : class {
  func header(_ profileHeader : ProfileHeader, didTapActionButtonFor user : User)
}

class ProfileHeader : UICollectionReusableView {
  
  //MARK: - Properties
  static let identifier = "ProfileHeader"
  
  weak var delegate : ProfileHeaderDelegate?
  
  private let profileImageView : UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.backgroundColor = .lightGray
    return iv
  }()
  
  private let nameLabel : UILabel = {
    let lb = UILabel()
    lb.textColor = .black
    lb.font = UIFont.boldSystemFont(ofSize: 14)
    return lb
  }()
  
  private lazy var editProfileFollowButton : UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Loading", for: .normal)
    button.layer.cornerRadius = 3
    button.layer.borderColor = UIColor.lightGray.cgColor
    button.layer.borderWidth = 0.5
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    button.setTitleColor(.black, for: .normal)
    button.addTarget(self, action: #selector(handleEditProfileFollowTapped), for: .touchUpInside)
    return button
  }()
  
  private lazy var postLabel : UILabel = {
    let lb = UILabel()
    lb.numberOfLines = 0
    lb.textAlignment = .center
    return lb
  }()
  
  private lazy var followersLabel : UILabel = {
    let lb = UILabel()
    lb.numberOfLines = 0
    lb.textAlignment = .center
    return lb
  }()
  
  private lazy var followingLabel : UILabel = {
    let lb = UILabel()
    lb.numberOfLines = 0
    lb.textAlignment = .center
    return lb
  }()
  
  let gridButton : UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
    return button
  }()
  
  let listButton : UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
    button.tintColor = UIColor(white: 0, alpha: 0.2)
    return button
  }()
  
  let bookmarkButton : UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
    button.tintColor = UIColor(white: 0, alpha: 0.2)
    return button
  }()
  
  var viewModel : ProfileHeaderViewModel? {
    didSet {
      configure()
    }
  }
  //MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Function
  private func configureUI() {
    backgroundColor = .white
    
    profileImageView.layer.cornerRadius = 80 / 2
    
    [profileImageView, nameLabel, editProfileFollowButton].forEach {
      addSubview($0)
    }
    
    profileImageView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(16)
      $0.leading.equalToSuperview().offset(12)
      $0.width.height.equalTo(80)
    }
    
    nameLabel.snp.makeConstraints {
      $0.top.equalTo(profileImageView.snp.bottom).offset(12)
      $0.leading.equalToSuperview().offset(12)
    }
    
    editProfileFollowButton.snp.makeConstraints {
      $0.top.equalTo(nameLabel.snp.bottom).offset(16)
      $0.leading.equalToSuperview().offset(24)
      $0.trailing.equalToSuperview().offset(-24)
    }
    
    let stack = UIStackView(arrangedSubviews: [postLabel, followersLabel, followingLabel])
    stack.distribution = .fillEqually
    addSubview(stack)
    stack.snp.makeConstraints {
      $0.centerY.equalTo(profileImageView)
      $0.leading.equalTo(profileImageView.snp.trailing).offset(12)
      $0.trailing.equalToSuperview().offset(-12)
      $0.height.equalTo(50)
    }
    
    let topDivider = UIView()
    topDivider.backgroundColor = .lightGray
    
    let bottomDivider = UIView()
    bottomDivider.backgroundColor = .lightGray
    
    let buttonStack = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
    buttonStack.distribution = .fillEqually
    
    
    [buttonStack, topDivider, bottomDivider].forEach {
      addSubview($0)
    }
    
    buttonStack.snp.makeConstraints {
      $0.leading.trailing.bottom.equalToSuperview()
      $0.height.equalTo(50)
    }
    
    topDivider.snp.makeConstraints {
      $0.top.equalTo(buttonStack.snp.top)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(0.5)
    }
    
    bottomDivider.snp.makeConstraints {
      $0.top.equalTo(buttonStack.snp.bottom)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(0.5)
    }
  }
  
  
  func configure() {
    guard let viewModel = viewModel else {return}
    nameLabel.text = viewModel.fullname
    profileImageView.sd_setImage(with: viewModel.profileImageUrl)
    editProfileFollowButton.setTitle(viewModel.followButtonText, for: .normal)
    editProfileFollowButton.setTitleColor(viewModel.followButtonTextColor, for: .normal)
    editProfileFollowButton.backgroundColor = viewModel.followButtonBackgroundColor
    
    postLabel.attributedText = viewModel.numberOfPosts
    followersLabel.attributedText = viewModel.numberOfFollowers
    followingLabel.attributedText = viewModel.numberOfFollowing
  }
  
  //MARK: - @objc func
  @objc func handleEditProfileFollowTapped() {
    guard let viewModel = viewModel else {return}
    delegate?.header(self, didTapActionButtonFor: viewModel.user)
  }
}
