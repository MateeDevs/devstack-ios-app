//
//  AppDependency.swift
//  Shipvio3
//
//  Created by Petr Chmelar on 24/07/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

protocol HasNoService {
}

struct AppDependency: HasNoService, HasLoginService, HasUserService {
    let loginService: LoginService
    let userService: UserService
}
