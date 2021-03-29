//
//  Created by Petr Chmelar on 18.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

struct RepositoryDependencyMock: RepositoryDependency {
    
    let authTokenRepository: AuthTokenRepository
    let locationRepository: LocationRepository
    let pushNotificationsRepository: PushNotificationsRepository
    let remoteConfigRepository: RemoteConfigRepository
    let userRepository: UserRepository
    
    init(
        authTokenRepository: AuthTokenRepository = AuthTokenRepositoryMock(),
        locationRepository: LocationRepository = LocationRepositoryMock(),
        pushNotificationsRepository: PushNotificationsRepository = PushNotificationsRepositoryMock(),
        remoteConfigRepository: RemoteConfigRepository = RemoteConfigRepositoryMock(),
        userRepository: UserRepository = UserRepositoryMock()
    ) {
        self.authTokenRepository = authTokenRepository
        self.locationRepository = locationRepository
        self.pushNotificationsRepository = pushNotificationsRepository
        self.remoteConfigRepository = remoteConfigRepository
        self.userRepository = userRepository
    }
}
