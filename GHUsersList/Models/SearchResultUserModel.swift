//
//  GHUserModel.swift
//  GHUsersList
//
//  Created by Hellen Soloviy on 07.04.2023.
//

import Foundation

// TODO: - remove if not needed
class SearchResultUserModel: Codable {

    var name: String
    var avatarURL: String?
    var id: Int
    var url: String
    
    var fullProfile: DetailedUserModel? = nil
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "login"
        case url = "html_url"
        case avatarURL = "avatar_url"
    }
    
}

