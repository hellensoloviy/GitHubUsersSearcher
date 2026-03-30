//
//  UserProfileLoaderService.swift
//  GHUsersList
//
//  Created by Hellen Soloviy on 09.04.2023.
//

import Foundation
import Combine

class UserProfileLoaderService {
    
    private var model: DetailedUserModel
    private var cancellable: AnyCancellable? = nil
    
    init(userModel: DetailedUserModel) {
        self.model = userModel
    }
    
    func load() {
        loadUserData()
    }
    
    func cancel() {
        cancellable?.cancel()
        cancellable = nil
    }
    
    //MARK: - Private
    private func loadUserData() {
        
        cancellable = UsersRelatedService().userProfile(for: model.username)
            .receive(on: DispatchQueue.main)
            .sink { error in
            switch error {
            case let .failure(error):
                print("Couldn't load user: \(error)")
            case .finished: break
            }
            
        } receiveValue: { [self] value in
            self.model.reposCount = value.reposCount
            self.model.email = value.email
            self.model.avatarURL = value.avatarURL
            self.model.about = value.about
            self.model.location = value.location
            self.model.joinedDate = value.joinedDate
            
            self.model.followers = value.followers
            self.model.following = value.following
        }
    }
    
}
