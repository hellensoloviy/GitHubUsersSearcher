//
//  RepositoriesService.swift
//  GHUsersList
//
//  Created by Hellen Soloviy on 07.04.2023.
//

import Foundation

protocol RepositoriesServicable {
    func repositories(for username: String) async -> Result<[RepositoryModel], RequestError>
}

struct RepositoriesService: NetworkClient, RepositoriesServicable {
    func repositories(for username: String) async -> Result<[RepositoryModel], RequestError> {
        return await sendRequest(endpoint: RepositoryEndpoint.reposForUser(username: username), responseModel: [RepositoryModel].self)
    }
}
