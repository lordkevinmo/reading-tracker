//
//  Endpoint.swift
//  Reading Tracker
//
//  Created by Moïse AGBENYA on 31/05/2021.
//

import Foundation

public enum Endpoint {
    case get(path: String)
    case post(path: String)
    case put(path: String)
    case delete(path: String)
    
    internal enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    internal var path: String {
        switch self {
        case let .get(path: path),
             let .post(path: path),
             let .put(path: path),
             let .delete(path: path):
        return path
        }
    }
    
    internal var method: HTTPMethod {
        switch self {
        case .get:
            return .get
        case .post:
            return .post
        case .put:
            return .put
        case .delete:
            return .delete
        }
    }
    
    internal var defaultParamDestination: ParamDestination {
        switch self {
        case .get:
            return .urlQuery
        case .post, .put, .delete:
            return .httpBody
        }
    }
}
