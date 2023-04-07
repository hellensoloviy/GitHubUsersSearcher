//
//  ViewController.swift
//  GHUsersList
//
//  Created by Hellen Soloviy on 07.04.2023.
//

import UIKit

class SearchUsersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!


    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
    }


}

//MARK: - Search Bar Delegate
extension SearchUsersViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

//MARK: - Search Bar Delegate
extension SearchUsersViewController: UITableViewDelegate {
    
}

//MARK: - Search Bar Delegate
extension SearchUsersViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {

    }
}


