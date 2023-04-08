//
//  DetailedUserModel.swift
//  GHUsersList
//
//  Created by Hellen Soloviy on 08.04.2023.
//

import Foundation

final class DetailedUserModel: Codable, ObservableObject {

    var id: Int = 0
    var name: String?
    var url: String?

    @Published var avatarURL: String?

    var followers: Int?
    var following: Int?
    var email: String?
    var joinedDate: String? // TODO: -- format data
    var location: String?
    var username: String
    var about: String?
    
    @Published var reposCount: Int?
    
    var repositories: [RepositoryModel]? = []
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "name"
        case url = "html_url"
        case avatarURL = "avatar_url"
        case followers
        case following
        case email
        case joinedDate = "created_at"
        case location
        case username = "login"
        case about = "bio"
        case reposCount = "public_repos"
        
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try? container.decode(String?.self, forKey: .name)
        id = try container.decode(Int.self, forKey: .id)
        url = try? container.decode(String?.self, forKey: .url)
        followers = try? container.decode(Int?.self, forKey: .followers)
        following = try? container.decode(Int?.self, forKey: .following)
        email = try? container.decode(String?.self, forKey: .email)
        username = try container.decode(String.self, forKey: .username)
        about = try? container.decode(String?.self, forKey: .about)
        location = try? container.decode(String?.self, forKey: .location)
        joinedDate = try? container.decode(String?.self, forKey: .joinedDate)
        reposCount = try? container.decode(Int?.self, forKey: .reposCount)
        avatarURL = try? container.decode(String?.self, forKey: .avatarURL)

    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.url, forKey: .url)
        try container.encodeIfPresent(self.avatarURL, forKey: .avatarURL)
        try container.encodeIfPresent(self.followers, forKey: .followers)
        try container.encodeIfPresent(self.following, forKey: .following)
        try container.encodeIfPresent(self.email, forKey: .email)
        try container.encodeIfPresent(self.joinedDate, forKey: .joinedDate)
        try container.encodeIfPresent(self.location, forKey: .location)
        try container.encode(self.username, forKey: .username)
        try container.encodeIfPresent(self.about, forKey: .about)
        try container.encodeIfPresent(self.reposCount, forKey: .reposCount)
    }

    
}
