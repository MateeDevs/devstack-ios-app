//
//  Created by Petr Chmelar on 23/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

struct ProviderDependencyMock: ProviderDependency {
    
    let databaseProvider: DatabaseProvider
    let keychainProvider: KeychainProvider
    let networkProvider: NetworkProvider
    let pushNotificationsProvider: PushNotificationsProvider
    let remoteConfigProvider: RemoteConfigProvider
    let userDefaultsProvider: UserDefaultsProvider
    
    init(
        databaseProvider: DatabaseProvider = DatabaseProviderMock(),
        keychainProvider: KeychainProvider = KeychainProviderMock(),
        networkProvider: NetworkProvider = NetworkProviderMock(),
        pushNotificationsProvider: PushNotificationsProvider = PushNotificationsProviderMock(),
        remoteConfigProvider: RemoteConfigProvider = RemoteConfigProviderMock(),
        userDefaultsProvider: UserDefaultsProvider = UserDefaultsProviderMock()
    ) {
        self.databaseProvider = databaseProvider
        self.keychainProvider = keychainProvider
        self.networkProvider = networkProvider
        self.pushNotificationsProvider = pushNotificationsProvider
        self.remoteConfigProvider = remoteConfigProvider
        self.userDefaultsProvider = userDefaultsProvider
    }
}
