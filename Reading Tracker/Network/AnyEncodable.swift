//
//  AnyEncodable.swift
//  Reading Tracker
//
//  Created by Moïse AGBENYA on 31/05/2021.
//

import Foundation

struct AnyEncodable: Encodable {
    
    private let encodable: Encodable
    
    public init(_ encodable: Encodable) {
        self.encodable = encodable
    }
    
    func encode(to encoder: Encoder) throws {
        try encodable.encode(to: encoder)
    }
}
