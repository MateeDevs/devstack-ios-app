//
//  RepositoryDependency.swift
//  DevStack
//
//  Created by Petr Chmelar on 24/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

public protocol HasNoRepository {}

extension RepositoryDependency: HasNoRepository {}
extension RepositoryDependency: HasAuthTokenRepository {}
extension RepositoryDependency: HasLocationRepository {}
extension RepositoryDependency: HasRemoteConfigRepository {}
extension RepositoryDependency: HasUserRepository {}

public struct RepositoryDependency {
    
    public let authTokenRepository: AuthTokenRepository
    public let locationRepository: LocationRepository
    public let remoteConfigRepository: RemoteConfigRepository
    public let userRepository: UserRepository
    
    init(dependencies: ProviderDependency) {
        self.authTokenRepository = AuthTokenRepository(dependencies: dependencies)
        self.locationRepository = LocationRepository(dependencies: dependencies)
        self.remoteConfigRepository = RemoteConfigRepository(dependencies: dependencies)
        self.userRepository = UserRepository(dependencies: dependencies)
    }
}
