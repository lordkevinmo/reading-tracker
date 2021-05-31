//
//  URLRequest  + Extensions.swift
//  Reading Tracker
//
//  Created by Moïse AGBENYA on 31/05/2021.
//

import Foundation

internal extension URLRequest {
    init(resource: Resource) {
        var url = resource.baseURL.appendingPathComponent(resource.endpoint.path)
        
        if case let .requestWithParameters(parameters, encoding) = resource.task, (encoding.destination ?? resource.endpoint.defaultParamDestination) == .urlQuery {
            url = url.appendingQueryParameters(parameters, encoding: encoding)
        }

        self.init(url: url)

        httpMethod = resource.endpoint.method.rawValue

        for (key, value) in resource.headers {
            addValue(value, forHTTPHeaderField: key)
        }

        if resource.endpoint.method == .post || resource.endpoint.method == .put,
            case let .requestWithEncodable(encodable) = resource.task {
            httpBody = encode(object: AnyEncodable(encodable))
        } else if case let .requestWithParameters(parameters, encoding) = resource.task, (encoding.destination ?? resource.endpoint.defaultParamDestination) == .httpBody {
            httpBody = encoding.query(parameters).data(using: .utf8)
        }
        
        cachePolicy = resource.cachePolicy
    }

    func encode<E>(object: E) -> Data? where E: Encodable {
        return try? JSONEncoder().encode(object)
    }
}
