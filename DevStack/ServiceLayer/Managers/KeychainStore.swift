//
//  KeychainStore.swift
//  DevStack
//
//  Created by Petr Chmelar on 01/08/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation
import KeychainAccess
import os.log

struct KeychainCoding {
    static let authToken = "authToken"
    static let userId = "userId"
}

class KeychainStore {
    
    static func save(key: String, value: String) {
        let keychain = Keychain(service: "\(Bundle.main.bundleIdentifier!)")
        keychain[key] = value
    }
    
    static func get(key: String) -> String? {
        let keychain = Keychain(service: "\(Bundle.main.bundleIdentifier!)")
        guard let value = keychain[key] else { return nil }
        return value
    }
    
    static func delete(key: String) {
        do {
            let keychain = Keychain(service: "\(Bundle.main.bundleIdentifier!)")
            try keychain.remove(key)
        } catch let error {
            os_log("Error during KeychainStore delete operation:\n%@", log: Logger.appLog(), type: .error, "\(error)")
        }
    }
    
    static func deleteAll() {
        let keychain = Keychain(service: "\(Bundle.main.bundleIdentifier!)")
        for key in keychain.allKeys() {
            delete(key: key)
        }
    }

}
