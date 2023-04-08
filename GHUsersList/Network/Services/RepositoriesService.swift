//
//  RepositoriesService.swift
//  GHUsersList
//
//  Created by Hellen Soloviy on 07.04.2023.
//

import Foundation
import Combine

protocol RepositoriesServicable {
    func repositories(for username: String) -> AnyPublisher<[RepositoryModel], RequestError>
}

struct RepositoriesService: NetworkClient, RepositoriesServicable {
    func repositories(for username: String) -> AnyPublisher<[RepositoryModel], RequestError> {
        return sendRequest(endpoint: RepositoryEndpoint.reposForUser(username: username), responseModel: [RepositoryModel].self)
    }
}
