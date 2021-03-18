//
//  Created by Petr Chmelar on 18.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

struct RepositoryDependencyMock: RepositoryDependencyType {
    
    let authTokenRepository: AuthTokenRepositoryType
    let locationRepository: LocationRepositoryType
    let pushNotificationsRepository: PushNotificationsRepositoryType
    let remoteConfigRepository: RemoteConfigRepositoryType
    let userRepository: UserRepositoryType
    
    init(
        authTokenRepository: AuthTokenRepositoryType = AuthTokenRepositoryMock(),
        locationRepository: LocationRepositoryType = LocationRepositoryMock(),
        pushNotificationsRepository: PushNotificationsRepositoryType = PushNotificationsRepositoryMock(),
        remoteConfigRepository: RemoteConfigRepositoryType = RemoteConfigRepositoryMock(),
        userRepository: UserRepositoryType = UserRepositoryMock()
    ) {
        self.authTokenRepository = authTokenRepository
        self.locationRepository = locationRepository
        self.pushNotificationsRepository = pushNotificationsRepository
        self.remoteConfigRepository = remoteConfigRepository
        self.userRepository = userRepository
    }
}