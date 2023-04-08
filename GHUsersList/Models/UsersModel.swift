//
//  UsersModel.swift
//  GHUsersList
//
//  Created by Hellen Soloviy on 07.04.2023.
//

import Foundation

struct UsersModel: Codable {
    
    var totalCount: Int
    var users: [GHUserModel]?
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case users = "items"
    }
}
