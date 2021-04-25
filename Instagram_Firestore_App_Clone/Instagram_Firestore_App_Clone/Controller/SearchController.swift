//
//  SearchController.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/03/21.
//

import UIKit

class SearchController : UITableViewController {
  
  //MARK: - Properties
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTableView()
  }
  
  //MARK: - Function
  private func configureTableView() {
    view.backgroundColor = .white
    
    tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)
    tableView.rowHeight = 64
    
  }
}

  //MARK: - extension UITableViewDataSource
extension SearchController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath)
    return cell
  }
}
