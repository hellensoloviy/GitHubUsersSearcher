//
//  UserTVC.swift
//  GHUsersList
//
//  Created by Hellen Soloviy on 07.04.2023.
//

import UIKit
import Combine

class UserTVC: UITableViewCell {
 
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var repositoriesCountLabel: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    private var loaderService: UserProfileLoaderService?
    private var model: DetailedUserModel?
    
    // MARK: -
    
    override func prepareForReuse() {
        super.prepareForReuse()
        removeLoader()
        model = nil
        repositoriesCountLabel.text = ""
        avatar.image = nil
        cancellable = Set<AnyCancellable>()
    }
    
    //MARK: - Binding
    
    func bindModel(_ model: DetailedUserModel) {
        self.model = model
        userNameLabel.text = model.username
        
        model.$avatarURL
           .sink { [weak self] count in
               guard let urlString = model.avatarURL, let url = URL(string: urlString) else { return }

               URLSession.shared
                   .downloadTaskPublisher(for: url)
                   .map { UIImage(contentsOfFile: $0.url.path)! }
                   .receive(on: DispatchQueue.main)
                   .replaceError(with: UIImage(named: "github-mark")) // white so we see when its not loaded
                   .assign(to: \.image, on: self!.avatar)
                   .store(in: &self!.cancellable)

           }.store(in: &cancellable)
        
         model.$reposCount
            .receive(on: DispatchQueue.main)
            .sink { [weak self] count in
                guard let count = count else { return }
                self?.repositoriesCountLabel.text = "\(count)"
            }.store(in: &cancellable)
    }
    
    // MARK: - Loader
    func addLoaderService(_ loder: UserProfileLoaderService) {
        self.loaderService = loder
        loaderService?.load()
    }
    
    func removeLoader() {
        loaderService?.cancel()
        self.loaderService = nil
    }
}

