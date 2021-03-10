//
//  Created by Petr Chmelar on 24/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

class UserDefaultsProviderMock: UserDefaultsProviderType {

    var savedKeys: [UserDefaultsCoding] = []

    func save<T>(_ key: UserDefaultsCoding, value: T) {
        print("UserDefaultsProviderMock.save called")
        savedKeys.append(key)
    }

    func get<T>(_ key: UserDefaultsCoding) -> T? {
        print("UserDefaultsProviderMock.get called")
        return nil
    }

    func delete(_ key: UserDefaultsCoding) {
        print("UserDefaultsProviderMock.delete called")
    }

    func deleteAll() {
        print("UserDefaultsProviderMock.deleteAll called")
    }
}
