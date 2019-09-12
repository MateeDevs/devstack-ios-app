//
//  Encodable+Extensions.swift
//  DevStack
//
//  Created by Petr Chmelar on 28/08/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Foundation

extension Encodable {
    
    private var data: Data {
        return try! JSONEncoder().encode(self)
    }
    
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: data)) as? [String: Any] ?? [:]
    }
}
