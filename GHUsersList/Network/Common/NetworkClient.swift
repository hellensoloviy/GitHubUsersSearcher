//
//  NetworkClient.swift
//  GHUsersList
//
//  Created by Hellen Soloviy on 07.04.2023.
//

import Foundation
import Combine

protocol NetworkClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) -> AnyPublisher<T, RequestError>
}

extension NetworkClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) -> AnyPublisher<T, RequestError> {
        
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
        
        return URLSession.shared.dataTaskPublisher(for: request)
                    .map(\.data)
                    .decode(type: T.self, decoder: JSONDecoder())
                    .mapError({ error in
                        switch error {
                         case is Swift.DecodingError:
                           return .decode
                        case let _ as URLError:
                           return .unknown
                         default:
                           return .unknown
                         }
                    })
                    .eraseToAnyPublisher()
        
//        do {
//            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
//            guard let response = response as? HTTPURLResponse else {
//                return .failure(.noResponse)
//            }
//            switch response.statusCode {
//            case 200...299:
//                guard let decodedResponse = try? JSONDecoder().decode(UsersModel.self, from: data) else {
//                    return .failure(.decode)
//                }
//                if let users = decodedResponse.users {
//                    return .success(users as! T)
//                } else {
//                    return .failure(.noResponse)
//                }
//
//            case 401:
//                return .failure(.unauthorized)
//            default:
//                return .failure(.unexpectedStatusCode)
//            }
//        } catch {
//            return .failure(.unknown)
//        }
    }
}
