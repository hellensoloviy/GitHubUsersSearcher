//
//  UsersRelatedEndpoints.swift
//  GHUsersList
//
//  Created by Hellen Soloviy on 07.04.2023.
//

import Foundation

enum UsersRelatedEndpoints {
    case searchUser(name: String = "") // https://api.github.com/search/users?q=Q // default 30 per page
    case userProfile(username: String) //   https://api.github.com/users/hellensoloviy
}

extension UsersRelatedEndpoints: Endpoint {
    var path: String {
        switch self {
        case .searchUser:
            return "/search/users"
        case .userProfile(let name):
            return "/users/\(name)"
        }
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .searchUser(let name):
            return [.init(name: "q", value: name)]
        case .userProfile(_): return nil

        }
    }
    
    var method: RequestMethod {
        switch self {
        case .searchUser, .userProfile:
            return .get
        }
    }

    var body: [String: String]? {
        switch self {
        case .searchUser, .userProfile:
            return nil
        }
    }
}
