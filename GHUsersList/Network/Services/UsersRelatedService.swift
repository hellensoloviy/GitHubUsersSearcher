//
//  UsersRelatedService.swift
//  GHUsersList
//
//  Created by Hellen Soloviy on 07.04.2023.
//

import Foundation

protocol UsersRelatedServicable {
    func searchUsers(for keyword: String) async -> Result<[GHUserModel], RequestError>
}

struct UsersRelatedService: NetworkClient, UsersRelatedServicable {
    func searchUsers(for keyword: String) async -> Result<[GHUserModel], RequestError> {
        return await sendRequest(endpoint: UsersRelatedEndpoints.searchUser(name: keyword), responseModel: [GHUserModel].self)
    }
}
