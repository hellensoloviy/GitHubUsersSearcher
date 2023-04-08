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
    var model: DetailedUserModel?
    
    // MARK: -
    
    override func prepareForReuse() {
        super.prepareForReuse()
        model = nil
        repositoriesCountLabel.text = ""
        avatar.image = nil // UIImage(named: "github-mark") //default one
        cancellable = Set<AnyCancellable>()
    }
    
    func bindModel(_ model: DetailedUserModel) {
        self.model = model
        userNameLabel.text = model.username
         
        UsersRelatedService().userProfile(for: model.username)
            .receive(on: DispatchQueue.main)
            .sink { error in
            switch error {
            case let .failure(error):
                print("Couldn't load user: \(error)")
            case .finished: break
            }
            
        } receiveValue: { [self] value in
            self.model?.reposCount = value.reposCount
            self.model?.email = value.email
            self.model?.avatarURL = value.avatarURL
        }.store(in: &cancellable)
        
        
        model.$avatarURL
           .sink { [weak self] count in
               guard let urlString = model.avatarURL, let url = URL(string: urlString) else { return }

               URLSession.shared
                   .downloadTaskPublisher(for: url)
                   .map { UIImage(contentsOfFile: $0.url.path)! }
                   .receive(on: DispatchQueue.main)
                   .replaceError(with: UIImage(named: "github-mark-white")) // white so we see when not loaded
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
}

