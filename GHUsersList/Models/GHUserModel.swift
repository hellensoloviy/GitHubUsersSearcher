//
//  GHUserModel.swift
//  GHUsersList
//
//  Created by Hellen Soloviy on 07.04.2023.
//

import Foundation

struct GHUserModel: Codable {

//    var starsCount: String?
//    var forksCount: String?
    var name: String
    var avatarURL: String?
    var id: Int
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "login"
        case url = "html_url"
//        case starsCount = "stargazers_count"
//        case forksCount = "forks_count"
        case avatarURL = "avatar_url"
    }
    
    
}
