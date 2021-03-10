//
//  Created by Petr Chmelar on 24/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import DataLayer
import DomainLayer

extension RepositoryDependency: HasNoRepository {}
extension RepositoryDependency: HasAuthTokenRepository {}
extension RepositoryDependency: HasLocationRepository {}
extension RepositoryDependency: HasPushNotificationsRepository {}
extension RepositoryDependency: HasRemoteConfigRepository {}
extension RepositoryDependency: HasUserRepository {}

public struct RepositoryDependency {
    
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
