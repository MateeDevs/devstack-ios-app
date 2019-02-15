// 
//  ProfileFlowController.swift
//  DevStack
//
//  Created by Petr Chmelar on 06/02/2019.
//  Copyright © 2019 Qest. All rights reserved.
//

import UIKit

class ProfileFlowController: FlowController {
    
    override func start() {
        super.start()
        let vc = StoryboardScene.Profile.initialScene.instantiate()
        navigationController.viewControllers = [vc]
    }
    
}
