//
//  MainTabController.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/03/21.
//

import UIKit
import Firebase
import YPImagePicker

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
    self.delegate = self
    
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
  
  // YPImagePicker 를 통해 사진을 선택하고 Next 를 눌렀을때 적용되는 함수
  func didFinishPickingMedia(_ picker : YPImagePicker) {
    picker.didFinishPicking { items, _ in
      picker.dismiss(animated: false) {
        guard let selectedImage = items.singlePhoto?.image else {return}
        
        let controller = UploadPostController()
        controller.selectedImage = selectedImage
        controller.delegate = self
        let navi = UINavigationController(rootViewController: controller)
        navi.modalPresentationStyle = .fullScreen
        self.present(navi, animated: false, completion: nil)
      }
    }
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

  //MARK: - extension UITabbarControllerDelegate
extension MainTabController : UITabBarControllerDelegate {
  func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
    
    let index = viewControllers?.firstIndex(of: viewController)
    
    if index == 2 {
      var config = YPImagePickerConfiguration() // ypImagePickerConfiguration 으로 세팅들을 해준다.
      config.library.mediaType = .photo
      config.shouldSaveNewPicturesToAlbum = false
      config.startOnScreen = .library
      config.screens = [.library]
      config.hidesStatusBar = false
      config.hidesBottomBar = false
      config.library.maxNumberOfItems = 1
      
      let picker = YPImagePicker(configuration: config)
      picker.modalPresentationStyle = .fullScreen
      present(picker, animated: true, completion: nil)
      
      didFinishPickingMedia(picker)
    }
    return true
  }
}

  //MARK: - extension UploadPostControllerDelegate
extension MainTabController : UploadPostControllerDelegate {
  func controllerDidFinishUploadingPost(_ controller: UploadPostController) {
    selectedIndex = 0
    controller.dismiss(animated: true, completion: nil)
  }
}
