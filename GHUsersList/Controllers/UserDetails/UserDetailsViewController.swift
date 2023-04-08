//
//  UserDetailsViewController.swift
//  GHUsersList
//
//  Created by Hellen Soloviy on 07.04.2023.
//

import UIKit

class UserDetailsViewController: UIViewController {
    static let id = "UserDetailsViewController"

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: ProfileHeaderView!

    var userModel: DetailedUserModel? = nil
    var repositoriesList: [RepositoryModel]? = nil {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    //MARK: -
    init?(userModel: DetailedUserModel, coder: NSCoder) {
        super.init(coder: coder)
        self.userModel = userModel
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    //MARK: - Private
    func setupUI() {
        guard let model = userModel else { return }
        headerView.setupView(with: model)
        view.updateConstraints()
    }
}

//MARK: - TableView DataSource
extension UserDetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoriesList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

//MARK: - TableView Delegate
extension UserDetailsViewController: UITableViewDelegate {
    
}

//MARK: - Search Bar Delegate
extension UserDetailsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {

    }
}

