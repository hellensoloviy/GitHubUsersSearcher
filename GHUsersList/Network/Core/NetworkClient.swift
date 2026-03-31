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
        let request = URLRequest.setup(using: endpoint)
        
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
    }
}
