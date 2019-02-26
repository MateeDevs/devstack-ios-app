//
//  FlowController.swift
//  DevStack
//
//  Created by Petr Chmelar on 06/02/2019.
//  Copyright © 2019 Qest. All rights reserved.
//

import UIKit

open class FlowController {
    
    public let navigationController: UINavigationController
    public let dependencies: AppDependency
    
    public init(navigationController: UINavigationController, dependencies: AppDependency) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    open func start() {
        // Override this method in a subclass and start the flow
    }
    
}
