//
//  UsersRelatedService.swift
//  GHUsersList
//
//  Created by Hellen Soloviy on 07.04.2023.
//

import Foundation
import Combine

protocol UsersRelatedServicable {
    func searchUsers(for keyword: String) -> AnyPublisher<UsersModel, RequestError>
    func userProfile(for username: String) -> AnyPublisher<DetailedUserModel, RequestError>

}

struct UsersRelatedService: NetworkClient, UsersRelatedServicable {
    func searchUsers(for keyword: String) -> AnyPublisher<UsersModel, RequestError> {
        return sendRequest(endpoint: UsersRelatedEndpoints.searchUser(name: keyword), responseModel: UsersModel.self)
    }
    func userProfile(for username: String) -> AnyPublisher<DetailedUserModel, RequestError> {
        return sendRequest(endpoint: UsersRelatedEndpoints.userProfile(username: username), responseModel: DetailedUserModel.self)
    }

}
