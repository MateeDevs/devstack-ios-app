//
//  AppDependency.swift
//  DevStack
//
//  Created by Petr Chmelar on 24/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

public protocol HasNoService {
}

public struct AppDependency: HasNoService, HasLoginService, HasUserService, HasLocationService, HasFirebaseService {
    
    public let loginService: LoginService
    public let userService: UserService
    public let locationService: LocationService
    public let firebaseService: FirebaseService
    
    public init() {
        let databaseProvider = DatabaseProvider()
        let networkProvider = NetworkProvider()
        
        self.loginService = LoginService(networkProvider: networkProvider)
        self.userService = UserService(databaseProvider: databaseProvider, networkProvider: networkProvider)
        self.locationService = LocationService()
        self.firebaseService = FirebaseService()
    }
}
