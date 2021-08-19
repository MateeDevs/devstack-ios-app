//
//  Created by Petr Chmelar on 23/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import DataLayer

public protocol ProviderDependency: HasNoProvider,
    HasDatabaseProvider,
    HasKeychainProvider,
    HasNetworkProvider,
    HasPushNotificationsProvider,
    HasRemoteConfigProvider,
    HasUserDefaultsProvider {}

public struct ProviderDependencyImpl: ProviderDependency {

    public let databaseProvider: DatabaseProvider
    public let keychainProvider: KeychainProvider
    public let networkProvider: NetworkProvider
    public let pushNotificationsProvider: PushNotificationsProvider
    public let remoteConfigProvider: RemoteConfigProvider
    public let userDefaultsProvider: UserDefaultsProvider

    public init(
        databaseProvider: DatabaseProvider,
        keychainProvider: KeychainProvider,
        networkProvider: NetworkProvider,
        pushNotificationsProvider: PushNotificationsProvider,
        remoteConfigProvider: RemoteConfigProvider,
        userDefaultsProvider: UserDefaultsProvider
    ) {
        self.databaseProvider = databaseProvider
        self.keychainProvider = keychainProvider
        self.networkProvider = networkProvider
        self.pushNotificationsProvider = pushNotificationsProvider
        self.remoteConfigProvider = remoteConfigProvider
        self.userDefaultsProvider = userDefaultsProvider
    }
}
