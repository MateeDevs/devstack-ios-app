//
//  Created by Petr Chmelar on 14/10/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import Foundation

public protocol HasUserDefaultsProvider {
    var userDefaultsProvider: UserDefaultsProviderType { get }
}

public enum UserDefaultsCoding: String, CaseIterable {
    case hasRunBefore
}

public protocol UserDefaultsProviderType {

    /// Save the given key/value combination
    func save<T>(_ key: UserDefaultsCoding, value: T)

    /// Try to retrieve a value for the given key
    func get<T>(_ key: UserDefaultsCoding) -> T?

    /// Delete value for the given key
    func delete(_ key: UserDefaultsCoding)

    /// Delete all records
    func deleteAll()
}

struct UserDefaultsProvider: UserDefaultsProviderType {
    
    func save<T>(_ key: UserDefaultsCoding, value: T) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func get<T>(_ key: UserDefaultsCoding) -> T? {
        UserDefaults.standard.object(forKey: key.rawValue) as? T
    }
    
    func delete(_ key: UserDefaultsCoding) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
    func deleteAll() {
        for key in UserDefaultsCoding.allCases {
            delete(key)
        }
    }
}
