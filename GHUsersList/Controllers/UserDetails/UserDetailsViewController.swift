//
//  UserDetailsViewController.swift
//  GHUsersList
//
//  Created by Hellen Soloviy on 07.04.2023.
//

import UIKit
import Combine

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
    
    private var subscriptions = Set<AnyCancellable>()

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
        
        if let userModel = userModel {
            RepositoriesService().repositories(for: userModel.username).sink { error in
                
                switch error {
                case let .failure(error):
                    print("Couldn't get users: \(error)")
                    self.showError(with: error.customMessage)
                case .finished: break
                }

            } receiveValue: { responseList in
                self.repositoriesList = responseList
            }.store(in: &subscriptions)
        }
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
        guard let model = repositoriesList?[indexPath.row] else {
            return UITableViewCell()
        }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryDetailsTVC().identifier) as? RepositoryDetailsTVC {
            cell.bindRepositoryModel(model)
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}

//MARK: - TableView Delegate
extension UserDetailsViewController: UITableViewDelegate {
    
}

//MARK: - Search Bar Delegate
extension UserDetailsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//        if searchText.isEmpty {
//        } else {
//            search(for: searchText)
//        }
    }
}

