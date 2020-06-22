//
//  ServiceDependency.swift
//  DevStack
//
//  Created by Petr Chmelar on 24/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

public protocol HasNoService {}

public struct ServiceDependency: HasNoService, HasLoginService, HasUserService, HasLocationService, HasFirebaseService {
    
    public let loginService: LoginService
    public let userService: UserService
    public let locationService: LocationService
    public let firebaseService: FirebaseService
    
    public init(dependencies: ProviderDependency) {
        self.loginService = LoginService(dependencies: dependencies)
        self.userService = UserService(dependencies: dependencies)
        self.locationService = LocationService(dependencies: dependencies)
        self.firebaseService = FirebaseService(dependencies: dependencies)
    }
}
