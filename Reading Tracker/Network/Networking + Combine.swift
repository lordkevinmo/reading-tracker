//
//  Networking + Combine.swift
//  Reading Tracker
//
//  Created by Moïse AGBENYA on 31/05/2021.
//

import Foundation

#if canImport(Combine)

import Foundation
import Combine

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension Networking {

    func requestPublisher(
        resource: R,
        session: NetworkingSession = URLSession.shared,
        queue: DispatchQueue = .main
        ) -> AnyPublisher<Response, NetworkingError> {
        let publisher = NetworkingPublisher<Response, NetworkingError> { [weak self] subscriber in
            return self?.request(
                resource: resource,
                session: session,
                queue: queue,
                completion: { result in
                    switch result {
                    case let .success(response):
                        _ = subscriber.receive(response)
                        subscriber.receive(completion: .finished)
                    case let .failure(error):
                        subscriber.receive(completion: .failure(error))
                    }
                }
            )
        }
        return publisher.eraseToAnyPublisher()
    }
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension AnyPublisher where Output == Response, Failure == NetworkingError {

    func map<D: Decodable>(to type: D.Type, decoder: JSONDecoder = .init()) -> AnyPublisher<D, NetworkingError> {
        return compactMap { $0.data }
            .decode(type: type, decoder: decoder)
            .mapError { error -> NetworkingError in
                guard let tinyNetworkingError = error as? NetworkingError else {
                    return .underlying(error, nil)
                }
                return tinyNetworkingError
            }
            .eraseToAnyPublisher()
    }
}


#endif
