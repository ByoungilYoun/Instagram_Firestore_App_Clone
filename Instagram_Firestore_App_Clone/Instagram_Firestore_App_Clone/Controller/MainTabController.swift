//
//  MainTabController.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/03/21.
//

import UIKit
import Firebase

class MainTabController : UITabBarController {
  
  //MARK: - Properties
  private var user : User? {
    didSet {
      guard let user = user else {return}
      configureViewControllers(withUser: user)
    }
  }
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    checkIfUserIsLoggedIn()
    fetchUser()
  }
  
  //MARK: - Helpers
  func configureViewControllers(withUser user : User) {
    view.backgroundColor = .white
    
    let layout = UICollectionViewFlowLayout()
    let feed = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: FeedController(collectionViewLayout: layout))
    let search = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: SearchController())
    let imageSelector = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: ImageSelectorController())
    let notifications = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"), rootViewController: NotificationsController())
    
    let profileController = ProfileController(user: user)
    let profile = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: profileController)
    
    viewControllers = [feed, search, imageSelector, notifications, profile]
    tabBar.tintColor = .black
  }
  
  // 선택안된 이미지와 선택된 이미지 그리고 UINavigationController 로 변형시켜 리턴 시켜주는 함수 
  func templateNavigationController(unselectedImage : UIImage, selectedImage : UIImage, rootViewController : UIViewController) -> UINavigationController {
    let navi = UINavigationController(rootViewController: rootViewController)
    navi.tabBarItem.image = unselectedImage
    navi.tabBarItem.selectedImage = selectedImage
    navi.navigationBar.tintColor = .black
    return navi
  }
  
  
  //MARK: - API
  func fetchUser() {
    UserService.fetchUser { user in
      self.user = user
    }
  }
  //MARK: - API
  func checkIfUserIsLoggedIn() {
    if Auth.auth().currentUser == nil {
      DispatchQueue.main.async {
        let controller = LoginController()
        controller.delegate = self 
        let navi = UINavigationController(rootViewController: controller)
        navi.modalPresentationStyle = .fullScreen
        self.present(navi, animated: true, completion: nil)
      }
    }
  }
}

  //MARK: - extension AuthenticationDelegate
extension MainTabController : AuthenticationDelegate {
  func authenticateDidComplete() {
    fetchUser()
    self.dismiss(animated: true, completion: nil)
  }
}
