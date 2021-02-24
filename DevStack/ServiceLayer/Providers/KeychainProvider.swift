//
//  KeychainProvider.swift
//  DevStack
//
//  Created by Petr Chmelar on 01/08/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Foundation
import KeychainAccess

protocol HasKeychainProvider {
    var keychainProvider: KeychainProviderType { get }
}

enum KeychainCoding: String, CaseIterable {
    case authToken
    case userId
}

protocol KeychainProviderType {

    /// Save the given key/value combination
    func save(_ key: KeychainCoding, value: String)

    /// Try to retrieve a value for the given key
    func get(_ key: KeychainCoding) -> String?

    /// Delete value for the given key
    func delete(_ key: KeychainCoding)

    /// Delete all records
    func deleteAll()
}

struct KeychainProvider: KeychainProviderType {
    
    func save(_ key: KeychainCoding, value: String) {
        let keychain = Keychain(service: "\(Bundle.main.bundleIdentifier!)")
        keychain[key.rawValue] = value
    }
    
    func get(_ key: KeychainCoding) -> String? {
        let keychain = Keychain(service: "\(Bundle.main.bundleIdentifier!)")
        guard let value = keychain[key.rawValue] else { return nil }
        return value
    }
    
    func delete(_ key: KeychainCoding) {
        do {
            let keychain = Keychain(service: "\(Bundle.main.bundleIdentifier!)")
            try keychain.remove(key.rawValue)
        } catch let error {
            Logger.error("Error during KeychainStore delete operation:\n%@", "\(error)", category: .app)
        }
    }
    
    func deleteAll() {
        for key in KeychainCoding.allCases {
            delete(key)
        }
    }
}
