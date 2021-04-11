//
//  MainTabController.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/03/21.
//

import UIKit
import Firebase

class MainTabController : UITabBarController {
  
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewControllers()
    checkIfUserIsLoggedIn()
  }
  
  //MARK: - Helpers
  func configureViewControllers() {
    view.backgroundColor = .white
    
    let layout = UICollectionViewFlowLayout()
    let feed = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: FeedController(collectionViewLayout: layout))
    let search = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: SearchController())
    let imageSelector = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: ImageSelectorController())
    let notifications = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"), rootViewController: NotificationsController())
    
    let profileLayout = UICollectionViewFlowLayout()
    let profile = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: ProfileController(collectionViewLayout: profileLayout))
    
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
  func checkIfUserIsLoggedIn() {
    if Auth.auth().currentUser == nil {
      DispatchQueue.main.async {
        let controller = LoginController()
        let navi = UINavigationController(rootViewController: controller)
        navi.modalPresentationStyle = .fullScreen
        self.present(navi, animated: true, completion: nil)
      }
    }
  }
}
