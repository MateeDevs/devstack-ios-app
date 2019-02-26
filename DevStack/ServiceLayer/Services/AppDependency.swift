//
//  AppDependency.swift
//  DevStack
//
//  Created by Petr Chmelar on 24/07/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

public protocol HasNoService {
}

public struct AppDependency: HasNoService, HasLoginService, HasUserService, HasLocationManager {
    public let loginService: LoginService
    public let userService: UserService
    public lazy var locationManager = LocationManager()
    
    public init(loginService: LoginService, userService: UserService) {
        self.loginService = loginService
        self.userService = userService
    }
}
