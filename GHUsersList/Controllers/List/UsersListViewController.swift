//
//  UsersListViewController.swift
//  GHUsersList
//
//  Created by Hellen Soloviy on 07.04.2023.
//

import UIKit
import Combine

enum SearchStatus {
    case initial
    case noResult
    case notStarted
    case error
    case resultsFound

    var shouldShowList: Bool {
        switch self {
        case .error, .notStarted, .noResult: return false
        case .initial, .resultsFound: return true

        }
    }
}
                        
                        
                        
class UsersListViewController: UIViewController {
   
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var emptyStateView: EmptyStateView!

    @Published private var userModel: UsersModel? = nil
    @Published private var isLoading: Bool = false
    @Published private var dataSource: [DetailedUserModel]? = nil
    @Published private var state = SearchStatus.initial
    
    private var subscriptions = Set<AnyCancellable>()
    private var searchSubscription: AnyCancellable? = nil
    

    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        state = .notStarted
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSubscriptions()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        subscriptions.forEach({ $0.cancel() })
        subscriptions = Set<AnyCancellable>()
    }
    
    //MARK: - Private
    private func search(for keyword: String = "") {
        isLoading = true
        searchSubscription = UsersRelatedService().searchUsers(for: keyword).sink { error in
            
            switch error {
            case let .failure(error):
                print("Couldn't get users: \(error)")
                self.handleError(message: error.customMessage)
                self.state = .error

            case .finished: break
            }
            self.isLoading = false
            
        } receiveValue: { value in
            
            self.userModel = value
            if let users = value.users, !users.isEmpty {
                self.dataSource = users
                self.state = .resultsFound
            } else {
                self.dataSource = nil
                self.state = .noResult
            }
        }
    }
    
    private func handleError(message: String? = nil) {
        self.showError(with: message)
        self.dataSource = nil
    }
    
    private func setupSubscriptions() {
        $dataSource.receive(on: DispatchQueue.main).sink { [weak self] new in
            guard let self = self else { return }
            self.tableView.reloadData()
        }.store(in: &subscriptions)
        
        $state.receive(on: DispatchQueue.main).sink { [weak self] new in
            guard let self = self else { return }
            self.tableView.isHidden = !new.shouldShowList
            self.emptyStateView.setup(with: new)
            self.isLoading = false
        }.store(in: &subscriptions)
        
        $isLoading.sink(receiveValue: { [weak self] new in
            guard let self = self, new != self.isLoading else { return }

            DispatchQueue.main.async {
                self.spinner.isHidden = !new
                self.tableView.isHidden = new || !self.state.shouldShowList
                new ? self.spinner.startAnimating() : self.spinner.stopAnimating()
            }
        }).store(in: &subscriptions)
    }
}

//MARK: - TableView DataSource
extension UsersListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("=== number of rows = \(dataSource?.count ?? 1111)")
        return dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = dataSource?[indexPath.row] else {
            return UITableViewCell()
        }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: UserTVC().identifier) as? UserTVC {
            cell.bindModel(model)
            cell.addLoaderService(UserProfileLoaderService(userModel: model))
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}

//MARK: - TableView Delegate
extension UsersListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let objectFor = dataSource?[indexPath.row] else { return }
        
        guard let vc = storyboard?.instantiateViewController(
            identifier: UserDetailsViewController.id,
            creator: { coder in
               UserDetailsViewController.init(userModel: objectFor, coder: coder)
            }
        ) else {
            fatalError("Failed to create Product Details VC")
        }
        
        self.navigationController?.show(vc, sender: nil)
    }
    
}

//MARK: - Search Bar Delegate
extension UsersListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchSubscription?.cancel()

        if searchText.isEmpty {
            userModel = nil
            dataSource = nil
            state = .notStarted
        } else {
            search(for: searchText)
        }
    }
    
}


