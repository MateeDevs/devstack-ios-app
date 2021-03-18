//
//  Created by Petr Chmelar on 23/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

struct ProviderDependencyMock: ProviderDependencyType {
    
    let databaseProvider: DatabaseProviderType
    let keychainProvider: KeychainProviderType
    let networkProvider: NetworkProviderType
    let pushNotificationsProvider: PushNotificationsProviderType
    let remoteConfigProvider: RemoteConfigProviderType
    let userDefaultsProvider: UserDefaultsProviderType
    
    init(
        databaseProvider: DatabaseProviderType = DatabaseProviderMock(),
        keychainProvider: KeychainProviderType = KeychainProviderTypeMock(),
        networkProvider: NetworkProviderType = NetworkProviderMock(),
        pushNotificationsProvider: PushNotificationsProviderType = PushNotificationsProviderTypeMock(),
        remoteConfigProvider: RemoteConfigProviderType = RemoteConfigProviderTypeMock(),
        userDefaultsProvider: UserDefaultsProviderType = UserDefaultsProviderTypeMock()
    ) {
        self.databaseProvider = databaseProvider
        self.keychainProvider = keychainProvider
        self.networkProvider = networkProvider
        self.pushNotificationsProvider = pushNotificationsProvider
        self.remoteConfigProvider = remoteConfigProvider
        self.userDefaultsProvider = userDefaultsProvider
    }
}
