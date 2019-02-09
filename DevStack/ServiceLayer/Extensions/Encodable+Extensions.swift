//
//  Encodable+Extensions.swift
//  Shipvio3
//
//  Created by Petr Chmelar on 28/08/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation

extension Encodable {
    subscript(key: String) -> Any? {
        return dictionary[key]
    }
    var data: Data {
        return try! JSONEncoder().encode(self)
    }
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: data)) as? [String: Any] ?? [:]
    }
}
