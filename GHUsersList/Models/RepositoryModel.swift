//
//  RepositoryModel.swift
//  GHUsersList
//
//  Created by Hellen Soloviy on 07.04.2023.
//

import Foundation

class RepositoryModel: Codable {
    
    var starsCount: String?
    var forksCount: String?
    var name: String?
    var url: String?
    var id: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case url = "html_url"
        case starsCount = "stargazers_count"
        case forksCount = "forks_count"
    }

}
