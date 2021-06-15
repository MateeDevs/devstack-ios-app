//
//  Created by Petr Chmelar on 24/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import DataLayer
import DomainLayer

public protocol RepositoryDependency: HasNoRepository,
    HasAuthTokenRepository,
    HasLocationRepository,
    HasPushNotificationsRepository,
    HasRemoteConfigRepository,
    HasUserRepository {}

public struct RepositoryDependencyImpl: RepositoryDependency {
    
    public let authTokenRepository: AuthTokenRepository
    public let locationRepository: LocationRepository
    public let pushNotificationsRepository: PushNotificationsRepository
    public let remoteConfigRepository: RemoteConfigRepository
    public let userRepository: UserRepository
    
    public init(dependencies: ProviderDependency) {
        self.authTokenRepository = AuthTokenRepositoryImpl(dependencies: dependencies)
        self.locationRepository = LocationRepositoryImpl(dependencies: dependencies)
        self.pushNotificationsRepository = PushNotificationsRepositoryImpl(dependencies: dependencies)
        self.remoteConfigRepository = RemoteConfigRepositoryImpl(dependencies: dependencies)
        self.userRepository = UserRepositoryImpl(dependencies: dependencies)
    }
}
