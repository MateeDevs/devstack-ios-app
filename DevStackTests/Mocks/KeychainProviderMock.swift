//
//  KeychainProviderMock.swift
//  DevStack
//
//  Created by Petr Chmelar on 23/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import Foundation
import KeychainAccess

@testable import DevStack

class KeychainProviderMock: KeychainProviderType {

    var savedKeys: [KeychainCoding] = []

    func save(_ key: KeychainCoding, value: String) {
        print("KeychainProviderMock.save called")
        savedKeys.append(key)
    }

    func get(_ key: KeychainCoding) -> String? {
        print("KeychainProviderMock.get called")
        return nil
    }

    func delete(_ key: KeychainCoding) {
        print("KeychainProviderMock.delete called")
    }

    func deleteAll() {
        print("KeychainProviderMock.deleteAll called")
    }
}
