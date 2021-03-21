//
//  MainTabController.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/03/21.
//

import UIKit

class MainTabController : UITabBarController {
  
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewControllers()
  }
  
  //MARK: - Helpers
  func configureViewControllers() {
    view.backgroundColor = .white
    
    let feed = FeedController()
    let search = SearchController()
    let imageSelector = ImageSelectorController()
    let notifications = NotificationsController()
    let profile = ProfileController()
    
    viewControllers = [feed, search, imageSelector, notifications, profile]
  }
}
