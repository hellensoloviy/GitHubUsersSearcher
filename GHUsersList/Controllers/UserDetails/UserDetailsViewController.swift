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
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    var userModel: DetailedUserModel? = nil
    var repositoriesList: [RepositoryModel]? = nil {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    
    @Published var isActionInProgress: Bool = false
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
                self.userModel?.repositories = responseList
                self.repositoriesList = responseList
            }.store(in: &subscriptions)
        }
        
        $isActionInProgress
            .receive(on: DispatchQueue.main)
            .sink { [weak self] new in
                
                DispatchQueue.main.async {
                    self?.spinner.isHidden = !new
                    self?.tableView.isHidden = new
                    new ? self?.spinner.startAnimating() : self?.spinner.stopAnimating()
                }
        }.store(in: &subscriptions)
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
    
    private func search(for keyword: String = "") {
        isActionInProgress = true
        let result = self.userModel?.repositories?.filter({ $0.name?.uppercased().contains(keyword.uppercased()) ?? false })
        self.repositoriesList = result
        isActionInProgress = false
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
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.repositoriesList = self.userModel?.repositories
            isActionInProgress = false
        } else {
            search(for: searchText)
        }
    }
}

