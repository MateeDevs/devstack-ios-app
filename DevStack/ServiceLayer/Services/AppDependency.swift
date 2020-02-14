//
//  AppDependency.swift
//  DevStack
//
//  Created by Petr Chmelar on 24/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

public protocol HasNoService {
}

public struct AppDependency: HasNoService, HasLoginService, HasUserService, HasLocationManager, HasFirebaseManager {
    public let loginService: LoginService
    public let userService: UserService
    public let locationManager: LocationManager
    public let firebaseManager: FirebaseManager

    public init(loginService: LoginService, userService: UserService, locationManager: LocationManager, firebaseManager: FirebaseManager) {
        self.loginService = loginService
        self.userService = userService
        self.locationManager = locationManager
        self.firebaseManager = firebaseManager
    }
}
