//
//  Task.swift
//  Reading Tracker
//
//  Created by Moïse AGBENYA on 31/05/2021.
//

import Foundation

public enum Task {
    case requestWithParameters([String: Any], encoding: URLEncoding)
    case requestWithEncodable(Encodable)
}
