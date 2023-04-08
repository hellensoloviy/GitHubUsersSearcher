//
//  RepositoryModel.swift
//  GHUsersList
//
//  Created by Hellen Soloviy on 07.04.2023.
//

import Foundation

class RepositoryModel: Codable {
    
    var starsCount: Int = 0
    var forksCount: Int = 0
    var name: String?
    var url: String
    var id: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case url = "html_url"
        case starsCount = "stargazers_count"
        case forksCount = "forks_count"
    }

}
