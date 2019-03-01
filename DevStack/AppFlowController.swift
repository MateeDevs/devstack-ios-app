//
//  AppFlowController.swift
//  DevStack
//
//  Created by Petr Chmelar on 17/07/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

class AppFlowController: FlowController {
    
    override func start() {
        super.start()
        let fc = MainFlowController(navigationController: navigationController, dependencies: dependencies)
        startChildFlow(fc)
    }
}
