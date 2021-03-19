//
//  Created by Petr Chmelar on 23/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

class KeychainProviderMock {
    
    var storage: [KeychainCoding: String] = [:]

    init(_ storage: [KeychainCoding: String] = [:]) {
        self.storage = storage
    }
}

extension KeychainProviderMock: KeychainProviderType {
    func save(_ key: KeychainCoding, value: String) {
        providerEvents.append(.keychainSave(key))
        storage[key] = value
    }

    func get(_ key: KeychainCoding) -> String? {
        providerEvents.append(.keychainGet(key))
        return storage[key]
    }

    func delete(_ key: KeychainCoding) {
        providerEvents.append(.keychainDelete(key))
        storage.removeValue(forKey: key)
    }

    func deleteAll() {
        providerEvents.append(.keychainDeleteAll)
        storage = [:]
    }
}
