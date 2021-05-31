//
//  NetworkingType.swift
//  Reading Tracker
//
//  Created by Moïse AGBENYA on 31/05/2021.
//

import Foundation

public protocol NetworkingType {

    associatedtype Resource

    func request(
        resource: Resource,
        session: NetworkingSession,
        queue: DispatchQueue,
        completion: @escaping (Result<Response, NetworkingError>) -> Void
        ) -> URLSessionDataTask
}
