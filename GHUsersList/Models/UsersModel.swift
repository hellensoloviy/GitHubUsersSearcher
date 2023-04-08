//
//  UsersModel.swift
//  GHUsersList
//
//  Created by Hellen Soloviy on 07.04.2023.
//

import Foundation

class UsersModel: Codable, ObservableObject {
    
    var totalCount: Int
    @Published var users: [DetailedUserModel]?
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case users = "items"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        users = try container.decode([DetailedUserModel]?.self, forKey: .users)
        totalCount = try container.decode(Int.self, forKey: .totalCount)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.totalCount, forKey: .totalCount)
        try container.encode(self.users, forKey: .users)

    }
}
