//
//  Created by Petr Chmelar on 12.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

enum ProviderEvent: Equatable {
    case databaseSave(_ type: DatabaseObjectType)
    case databaseGet(_ type: DatabaseObjectType)
    case databaseDeleteAll
    
    case keychainSave(_ key: KeychainCoding)
    case keychainGet(_ key: KeychainCoding)
    case keychainDelete(_ key: KeychainCoding)
    case keychainDeleteAll
    
    case networkRequest
    
    case pushNotificationsRequestAuthorization
    
    case remoteConfigGet(_ key: RemoteConfigCoding)
    
    case userDefaultsSave(_ key: UserDefaultsCoding)
    case userDefaultsGet(_ key: UserDefaultsCoding)
    case userDefaultsDelete(_ key: UserDefaultsCoding)
    case userDefaultsDeleteAll
}

enum DatabaseObjectType: String {
    case user = "DBUser"
    case undefined
}
