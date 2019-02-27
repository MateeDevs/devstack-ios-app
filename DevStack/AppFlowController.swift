//
//  AppFlowController.swift
//  DevStack
//
//  Created by Petr Chmelar on 17/07/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

class AppFlowController {
    
    private let window: UIWindow
    private let dependencies: AppDependency
    
    init(window: UIWindow) {
        self.window = window
        dependencies = AppDependency(
            loginService: LoginService(),
            userService: UserService()
        )
    }
    
    func start() {
        let navController = UINavigationController()
        window.rootViewController = navController
        window.makeKeyAndVisible()
        let flowController = MainFlowController(navigationController: navController, dependencies: dependencies)
        flowController.start()
    }
}
