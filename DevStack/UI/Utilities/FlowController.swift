//
//  FlowController.swift
//  DevStack
//
//  Created by Petr Chmelar on 06/02/2019.
//  Copyright © 2019 Qest. All rights reserved.
//

import UIKit

class FlowController {
    
    public let navigationController: UINavigationController
    public let dependencies: AppDependency
    
    init(navigationController: UINavigationController, dependencies: AppDependency) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    // Method to be overridden in subclasses
    func start() {
    }
    
}
