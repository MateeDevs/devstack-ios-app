//
//  Created by Petr Chmelar on 24/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import DataLayer
import DomainLayer

public protocol RepositoryDependencyType: HasNoRepository,
    HasAuthTokenRepository,
    HasLocationRepository,
    HasPushNotificationsRepository,
    HasRemoteConfigRepository,
    HasUserRepository {}

public struct RepositoryDependency: RepositoryDependencyType {
    
    public let authTokenRepository: AuthTokenRepositoryType
    public let locationRepository: LocationRepositoryType
    public let pushNotificationsRepository: PushNotificationsRepositoryType
    public let remoteConfigRepository: RemoteConfigRepositoryType
    public let userRepository: UserRepositoryType
    
    public init(dependencies: ProviderDependency) {
        self.authTokenRepository = AuthTokenRepository(dependencies: dependencies)
        self.locationRepository = LocationRepository(dependencies: dependencies)
        self.pushNotificationsRepository = PushNotificationsRepository(dependencies: dependencies)
        self.remoteConfigRepository = RemoteConfigRepository(dependencies: dependencies)
        self.userRepository = UserRepository(dependencies: dependencies)
    }
}
