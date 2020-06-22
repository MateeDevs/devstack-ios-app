//
//  ProviderDependency.swift
//  DevStack
//
//  Created by Petr Chmelar on 23/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

protocol HasNoProvider {}

public struct ProviderDependency: HasNoProvider, HasDatabaseProvider, HasKeychainProvider, HasNetworkProvider, HasUserDefaultsProvider {

    let databaseProvider: DatabaseProviderType
    let keychainProvider: KeychainProviderType
    let networkProvider: NetworkProviderType
    let userDefaultsProvider: UserDefaultsProviderType

    public init(
        databaseProvider: DatabaseProviderType,
        keychainProvider: KeychainProviderType,
        networkProvider: NetworkProviderType,
        userDefaultsProvider: UserDefaultsProviderType
    ) {
        self.databaseProvider = databaseProvider
        self.keychainProvider = keychainProvider
        self.networkProvider = networkProvider
        self.userDefaultsProvider = userDefaultsProvider
    }
}
