//
//  RepositoryDependency.swift
//  DevStack
//
//  Created by Petr Chmelar on 24/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

public protocol HasNoRepository {}

extension RepositoryDependency: HasNoRepository {}
extension RepositoryDependency: HasAuthRepository {}
extension RepositoryDependency: HasUserRepository {}
extension RepositoryDependency: HasLocationRepository {}
extension RepositoryDependency: HasPushNotificationsRepository {}

public struct RepositoryDependency {
    
    public let authRepository: AuthRepository
    public let userRepository: UserRepository
    public let locationRepository: LocationRepository
    public let pushNotificationsRepository: PushNotificationsRepository
    
    public init(dependencies: ProviderDependency) {
        self.authRepository = AuthRepository(dependencies: dependencies)
        self.userRepository = UserRepository(dependencies: dependencies)
        self.locationRepository = LocationRepository(dependencies: dependencies)
        self.pushNotificationsRepository = PushNotificationsRepository(dependencies: dependencies)
    }
}
