//
//  UsersFlowController.swift
//  DevStack
//
//  Created by Petr Chmelar on 28/01/2019.
//  Copyright © 2019 Qest. All rights reserved.
//

import UIKit

class UsersFlowController: FlowController {
    
    override func start() {
        super.start()
        let vc = StoryboardScene.Users.initialScene.instantiate()
        vc.viewModel = UsersViewModel(dependencies: dependencies)
        navigationController.viewControllers = [vc]
    }
    
}
