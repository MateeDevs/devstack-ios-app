//
//  UserDefaultsStore.swift
//  DevStack
//
//  Created by Petr Chmelar on 14/10/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import Foundation

enum UserDefaultsCoding: String, CaseIterable {
    case hasRunBefore
    case selectedLanguage
}

struct UserDefaultsStore {
    
    static func save<T>(_ key: UserDefaultsCoding, value: T) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    static func get<T>(_ key: UserDefaultsCoding) -> T? {
        return UserDefaults.standard.object(forKey: key.rawValue) as? T
    }
    
    static func delete(_ key: UserDefaultsCoding) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
    static func deleteAll() {
        for key in UserDefaultsCoding.allCases {
            delete(key)
        }
    }

}
