//
//  URLRequest+Setup.swift
//  GHUsersList
//
//  Created by Hellen Soloviy on 08.04.2023.
//

import Foundation

extension URLRequest {
    
   static func setup(using endpoint: Endpoint) -> URLRequest {
        var urlComponents = URLComponents()
       
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.queryItems
        
        guard let url = urlComponents.url else {
            fatalError("should not be like this!")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header

        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        return request
    }
}
