//
//  KeychainStore.swift
//  DevStack
//
//  Created by Petr Chmelar on 01/08/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Foundation
import KeychainAccess

enum KeychainCoding: String, CaseIterable {
    case authToken
    case userId
}

struct KeychainStore {
    
    static func save(_ key: KeychainCoding, value: String) {
        let keychain = Keychain(service: "\(Bundle.main.bundleIdentifier!)")
        keychain[key.rawValue] = value
    }
    
    static func get(_ key: KeychainCoding) -> String? {
        let keychain = Keychain(service: "\(Bundle.main.bundleIdentifier!)")
        guard let value = keychain[key.rawValue] else { return nil }
        return value
    }
    
    static func delete(_ key: KeychainCoding) {
        do {
            let keychain = Keychain(service: "\(Bundle.main.bundleIdentifier!)")
            try keychain.remove(key.rawValue)
        } catch let error {
            Logger.error("Error during KeychainStore delete operation:\n%@", "\(error)", category: .app)
        }
    }
    
    static func deleteAll() {
        for key in KeychainCoding.allCases {
            delete(key)
        }
    }

}
