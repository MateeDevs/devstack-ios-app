//
//  ProviderDependency.swift
//  DevStack
//
//  Created by Petr Chmelar on 23/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

protocol HasNoProvider {}

extension ProviderDependency: HasNoProvider {}
extension ProviderDependency: HasDatabaseProvider {}
extension ProviderDependency: HasKeychainProvider {}
extension ProviderDependency: HasNetworkProvider {}
extension ProviderDependency: HasPushNotificationsProvider {}
extension ProviderDependency: HasUserDefaultsProvider {}

struct ProviderDependency {

    let databaseProvider: DatabaseProviderType
    let keychainProvider: KeychainProviderType
    let networkProvider: NetworkProviderType
    let pushNotificationsProvider: PushNotificationsProviderType
    let userDefaultsProvider: UserDefaultsProviderType

    init(
        databaseProvider: DatabaseProviderType,
        keychainProvider: KeychainProviderType,
        networkProvider: NetworkProviderType,
        pushNotificationsProvider: PushNotificationsProviderType,
        userDefaultsProvider: UserDefaultsProviderType
    ) {
        self.databaseProvider = databaseProvider
        self.keychainProvider = keychainProvider
        self.networkProvider = networkProvider
        self.pushNotificationsProvider = pushNotificationsProvider
        self.userDefaultsProvider = userDefaultsProvider
    }
}
