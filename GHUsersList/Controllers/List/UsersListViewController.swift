//
//  UsersListViewController.swift
//  GHUsersList
//
//  Created by Hellen Soloviy on 07.04.2023.
//

import UIKit

class UsersListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    private var dataSource: [GHUserModel]? = nil {
        didSet {
            tableView.reloadData()
        }
    }

    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let serive = UsersRelatedService()
        Task(priority: .background) {
        let result = await serive.searchUsers(for: "hellen")
          switch result {
          case .success(let response):
              
              print("---- response \(response)")
              dataSource = response
              
          case .failure(let error):
              print("---- Errror \(error)")
          }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }

}

//MARK: - Search Bar Delegate
extension UsersListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = dataSource?[indexPath.row] else {
            return UITableViewCell()
        }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: UserTVC().identifier) as? UserTVC {
            cell.bindModel(model)
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}

//MARK: - Search Bar Delegate
extension UsersListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: -- navigation
        
//        let detailsVC = UserDetailsViewController()
//        self.navigationController?.show(detailsVC, sender: nil)
    }
    
}

//MARK: - Search Bar Delegate
extension UsersListViewController: UISearchBarDelegate {

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}


