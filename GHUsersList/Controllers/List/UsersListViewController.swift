//
//  UsersListViewController.swift
//  GHUsersList
//
//  Created by Hellen Soloviy on 07.04.2023.
//

import UIKit
import Combine

class UsersListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    @Published private var userModel: UsersModel? = nil
    private var dataSource: [DetailedUserModel]? = nil {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private var cancellable: AnyCancellable?
    
    @Published private var isLoading: Bool = false
    private var subscriptions = Set<AnyCancellable>()

    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cancellable = $isLoading.sink(receiveValue: { [weak self] new in
            guard new != self?.isLoading else { return }

            DispatchQueue.main.async {
                self?.spinner.isHidden = !new
                self?.tableView.isHidden = new
                new ? self?.spinner.startAnimating() : self?.spinner.stopAnimating()
            }
        })
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    //MARK: - Private
    private func search(for keyword: String = "") {
        isLoading = true
        UsersRelatedService().searchUsers(for: keyword).sink { error in
            
            switch error {
            case let .failure(error):
                print("Couldn't get users: \(error)")
                self.handleError(message: error.customMessage)
            case .finished: break
            }
            self.isLoading = false
            
        } receiveValue: { [self] value in
            
            userModel = value
            if let users = value.users {
                self.dataSource = users
            } else {
                self.dataSource = nil
            }
            self.isLoading = false
        }.store(in: &subscriptions)
    }
    
    private func getDetailedUsersData() {
    }
    
    private func handleError(message: String? = nil) {
        self.showError(with: message)
        self.dataSource = nil
    }
    
    private func createSpinnerView() {
        let child = SpinnerViewController()

        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)

        cancellable = $isLoading.sink(receiveValue: { [weak self] new in
            guard new != self?.isLoading else { return }
            if new {
                DispatchQueue.main.async {
                    child.willMove(toParent: nil)
                    child.view.removeFromSuperview()
                    child.removeFromParent()
                }
            }
            self?.cancellable = nil
           })
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
        if searchText.isEmpty {
            userModel = nil
            dataSource = nil
        } else {
            search(for: searchText)
        }
    }
}


