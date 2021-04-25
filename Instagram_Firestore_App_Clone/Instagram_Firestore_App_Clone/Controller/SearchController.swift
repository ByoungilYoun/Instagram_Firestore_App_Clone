//
//  SearchController.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/03/21.
//

import UIKit

class SearchController : UITableViewController {
  
  //MARK: - Properties
  
  private var users = [User]()
  
  private var filteredUsers = [User]()
  
  private let searchController = UISearchController(searchResultsController: nil)
  
  private var inSearchMode : Bool {
    return searchController.isActive && !searchController.searchBar.text!.isEmpty // 텍스트가 비어있을때도 신경써야함
  }
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureSearchController()
    configureTableView()
    fetchUsers()
  }
  
  //MARK: - Function
  private func configureTableView() {
    view.backgroundColor = .white
    
    tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)
    tableView.rowHeight = 64
    
  }
  
  private func configureSearchController() {
    searchController.searchResultsUpdater = self // extension UISearchResultsUpdating 해줘야한다.
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.hidesNavigationBarDuringPresentation = false
    searchController.searchBar.placeholder = "Search"
    navigationItem.searchController = searchController
    definesPresentationContext = false
  }
  
  private func fetchUsers() {
    UserService.fetchUsers { users in
      self.users = users
      self.tableView.reloadData()
    }
  }
}

  //MARK: - extension UITableViewDataSource
extension SearchController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return inSearchMode ? filteredUsers.count : users.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as! UserCell
    let user = inSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
    cell.viewModel = UserCellViewModel(user: user)
    return cell
  }
}

  //MARK: - extension UITableViewDelegate
extension SearchController {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let user = inSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
    let controller = ProfileController(user: user)
    navigationController?.pushViewController(controller, animated: true)
  }
}

  //MARK: - extension UISerachResultsUpdating
extension SearchController : UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    guard let searchText = searchController.searchBar.text?.lowercased() else {return}
    
    filteredUsers = users.filter({ $0.username.contains(searchText) || $0.fullname.lowercased().contains(searchText)})
    
    self.tableView.reloadData()
  }
}
