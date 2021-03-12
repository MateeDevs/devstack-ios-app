//
//  Created by Petr Chmelar on 24/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

class UserDefaultsProviderMock {
    
    var storage: [UserDefaultsCoding: Any] = [:]

    init(_ storage: [UserDefaultsCoding: Any] = [:]) {
        self.storage = storage
    }
}

extension UserDefaultsProviderMock: UserDefaultsProviderType {
    func save<T>(_ key: UserDefaultsCoding, value: T) {
        providerEvents.append(.userDefaultsSave(key))
        storage[key] = value
    }

    func get<T>(_ key: UserDefaultsCoding) -> T? {
        providerEvents.append(.userDefaultsGet(key))
        return storage[key] as? T
    }

    func delete(_ key: UserDefaultsCoding) {
        providerEvents.append(.userDefaultsDelete(key))
        storage.removeValue(forKey: key)
    }

    func deleteAll() {
        providerEvents.append(.userDefaultsDeleteAll)
        storage = [:]
    }
}
