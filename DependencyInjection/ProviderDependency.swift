//
//  Created by Petr Chmelar on 23/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import DataLayer

extension ProviderDependency: HasNoProvider {}
extension ProviderDependency: HasDatabaseProvider {}
extension ProviderDependency: HasKeychainProvider {}
extension ProviderDependency: HasNetworkProvider {}
extension ProviderDependency: HasPushNotificationsProvider {}
extension ProviderDependency: HasRemoteConfigProvider {}
extension ProviderDependency: HasUserDefaultsProvider {}

public struct ProviderDependency {

    public let databaseProvider: DatabaseProviderType
    public let keychainProvider: KeychainProviderType
    public let networkProvider: NetworkProviderType
    public let pushNotificationsProvider: PushNotificationsProviderType
    public let remoteConfigProvider: RemoteConfigProviderType
    public let userDefaultsProvider: UserDefaultsProviderType

    public init(
        databaseProvider: DatabaseProviderType,
        keychainProvider: KeychainProviderType,
        networkProvider: NetworkProviderType,
        pushNotificationsProvider: PushNotificationsProviderType,
        remoteConfigProvider: RemoteConfigProviderType,
        userDefaultsProvider: UserDefaultsProviderType
    ) {
        self.databaseProvider = databaseProvider
        self.keychainProvider = keychainProvider
        self.networkProvider = networkProvider
        self.pushNotificationsProvider = pushNotificationsProvider
        self.remoteConfigProvider = remoteConfigProvider
        self.userDefaultsProvider = userDefaultsProvider
    }
}
