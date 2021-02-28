//
//  Created by Petr Chmelar on 24/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

public protocol HasNoRepository {}

extension RepositoryDependency: HasNoRepository {}
extension RepositoryDependency: HasAuthTokenRepository {}
extension RepositoryDependency: HasUserRepository {}
extension RepositoryDependency: HasLocationRepository {}

public struct RepositoryDependency {

    public let authTokenRepository: AuthTokenRepository
    public let userRepository: UserRepository
    public let locationRepository: LocationRepository
    
    init(dependencies: ProviderDependency) {
        self.authTokenRepository = AuthTokenRepository(dependencies: dependencies)
        self.userRepository = UserRepository(dependencies: dependencies)
        self.locationRepository = LocationRepository(dependencies: dependencies)
    }
}
