//
//  Created by Petr Chmelar on 18.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DependencyInjection
import DomainLayer

struct RepositoryDependencyMock: RepositoryDependency {
    
    let analyticsRepository: AnalyticsRepository
    let authTokenRepository: AuthTokenRepository
    let locationRepository: LocationRepository
    let pushNotificationsRepository: PushNotificationsRepository
    let remoteConfigRepository: RemoteConfigRepository
    let userRepository: UserRepository
    
    init(
        analyticsRepository: AnalyticsRepository = AnalyticsRepositoryMock(),
        authTokenRepository: AuthTokenRepository = AuthTokenRepositoryMock(),
        locationRepository: LocationRepository = LocationRepositoryMock(),
        pushNotificationsRepository: PushNotificationsRepository = PushNotificationsRepositoryMock(),
        remoteConfigRepository: RemoteConfigRepository = RemoteConfigRepositoryMock(),
        userRepository: UserRepository = UserRepositoryMock()
    ) {
        self.analyticsRepository = analyticsRepository
        self.authTokenRepository = authTokenRepository
        self.locationRepository = locationRepository
        self.pushNotificationsRepository = pushNotificationsRepository
        self.remoteConfigRepository = remoteConfigRepository
        self.userRepository = userRepository
    }
}
