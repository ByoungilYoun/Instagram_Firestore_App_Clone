//
//  ProfileController.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/03/21.
//

import UIKit

class ProfileController : UICollectionViewController {
  
  //MARK: - Properties
  
  private var user : User
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
    checkIfUserIsFollowed()
    fetchUserStats()
  }
  
  init(user : User) {
    self.user = user
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: -  Helpers
  func configureCollectionView() {
    navigationItem.title = user.username
    collectionView.backgroundColor = .white
    collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: ProfileCell.identifier)
    collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileHeader.identifier)
  }
  
  // 해당 유저가 팔로우를 하는지 판별하는 함수
  func checkIfUserIsFollowed() {
    UserService.checkIfUserIsFollowed(uid: user.uid) { isFollowed in
      self.user.isFollowed = isFollowed
      self.collectionView.reloadData()
    }
  }
  
  // 팔로잉, 팔로워 명수 가져오는 함수
  func fetchUserStats() {
    UserService.fetchUserStats(uid: user.uid) { stats in
      self.user.stats = stats
      self.collectionView.reloadData()
      print("Debug : stats \(stats)")
    }
  }
}

  //MARK: - UICollectionViewDataSource
extension ProfileController  {
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 9
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCell.identifier, for: indexPath) as! ProfileCell
    return cell
  }
  
  // 헤더 뷰 생성
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileHeader.identifier, for: indexPath) as! ProfileHeader
    header.delegate = self
    header.viewModel = ProfileHeaderViewModel(user: user)
    return header
  }
}

  //MARK: - UICollectionViewDelegate
extension ProfileController {
  
}

  //MARK: - UICollectionViewDelegateFlowLayout
extension ProfileController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (view.frame.width - 2) / 3
    return CGSize(width: width, height: width)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: view.frame.width, height: 240)
  }
}

  //MARK: - extension ProfileHeaderDelegate
extension ProfileController : ProfileHeaderDelegate {
  func header(_ profileHeader: ProfileHeader, didTapActionButtonFor user: User) {
    if user.isCurrentUser {
      print("Debug : Show edit profile here")
    } else if user.isFollowed {
      UserService.unfollow(uid: user.uid) { error in
        self.user.isFollowed = false
        self.collectionView.reloadData()
      }
    } else {
      UserService.follow(uid: user.uid) { error in
        self.user.isFollowed = true
        self.collectionView.reloadData()
      }
    }
  }
}
