//
//  Endpoint.swift
//  GHUsersList
//
//  Created by Hellen Soloviy on 07.04.2023.
//

import Foundation

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"

}

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }

    var host: String {
        return "api.github.com"    //"://developer.github.com/v3"
    }
    
    var header: [String: String]? {
        return [
            "X-GitHub-Api-Version": "2022-11-28",
            "Content-Type": "application/json;charset=utf-8",
            "Accept": "application/vnd.github+json",
            "User-Agent": "GHUsersSearchersApp_APIDemo",
            "Authorization": "Bearer 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" // personal token - classic
        ]
    }
}
