//
//  AppDependency+Mock.swift
//  DevStack
//
//  Created by Petr Chmelar on 23/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import Foundation

@testable import A_DevStack

extension ProviderDependency {

    static func mock(
        databaseProvider: DatabaseProviderType = DatabaseProviderMock(),
        keychainProvider: KeychainProviderType = KeychainProviderMock(),
        networkProvider: NetworkProviderType = NetworkProviderMock(),
        pushNotificationsProvider: PushNotificationsProviderType = PushNotificationsProviderMock(),
        userDefaultsProvider: UserDefaultsProviderType = UserDefaultsProviderMock()
    ) -> ProviderDependency {
        .init(
            databaseProvider: databaseProvider,
            keychainProvider: keychainProvider,
            networkProvider: networkProvider,
            pushNotificationsProvider: pushNotificationsProvider,
            userDefaultsProvider: userDefaultsProvider
        )
    }

    static func mock(networkResponse: ResponseType) -> ProviderDependency {
        mock(networkProvider: NetworkProviderMock(response: networkResponse))
    }
}
