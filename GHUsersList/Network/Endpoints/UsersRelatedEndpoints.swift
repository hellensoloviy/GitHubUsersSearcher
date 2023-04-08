//
//  UsersRelatedEndpoints.swift
//  GHUsersList
//
//  Created by Hellen Soloviy on 07.04.2023.
//

import Foundation

enum UsersRelatedEndpoints {
    case searchUser(name: String = "") // https://api.github.com/search/users?q=Q // default 30 per page
}

extension UsersRelatedEndpoints: Endpoint {
    var path: String {
        switch self {
        case .searchUser:
            return "/search/users"
        }
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .searchUser(let name):
            return [.init(name: "q", value: name)]
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .searchUser:
            return .get
        }
    }

    var body: [String: String]? {
        switch self {
        case .searchUser:
            return nil
        }
    }
}
