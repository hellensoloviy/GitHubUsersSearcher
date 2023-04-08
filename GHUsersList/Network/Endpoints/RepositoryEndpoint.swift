//
//  RepositoryEndpoint.swift
//  GHUsersList
//
//  Created by Hellen Soloviy on 07.04.2023.
//

import Foundation

enum RepositoryEndpoint {
    case searchRepository(name: String = "") // TODO: -- find this request in API
    case reposForUser(username: String) // https://api.github.com/users/USERNAME/repos
}

extension RepositoryEndpoint: Endpoint {
    var path: String {
        switch self {
        case .searchRepository(_):
            return "error_url" // TODO: -- find this request in API
        case .reposForUser(let username):
            return "/users/\(username)/repos"
        }
    }
    
    var queryItems: [URLQueryItem]? { return nil }

    var method: RequestMethod {
        switch self {
        case .searchRepository, .reposForUser:
            return .get
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .searchRepository, .reposForUser:
            return nil
        }
    }
}
