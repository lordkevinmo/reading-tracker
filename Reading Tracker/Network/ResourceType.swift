//
//  ResourceType.swift
//  Reading Tracker
//
//  Created by Moïse AGBENYA on 31/05/2021.
//

import Foundation

public protocol Resource {
    var baseURL: URL { get }
    var endpoint: Endpoint { get }
    var task: Task { get }
    var headers: [String: String] { get }
    var cachePolicy: URLRequest.CachePolicy { get }
}

public extension Resource {
    var cachePolicy: URLRequest.CachePolicy {
        return .useProtocolCachePolicy
    }
}
