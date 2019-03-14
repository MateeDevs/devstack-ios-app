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
    
    private weak var parentController: FlowController?
    private var childControllers: [FlowController] = []
    
    public init(navigationController: UINavigationController, dependencies: AppDependency) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    /// Override this method in a subclass and start the flow
    open func start() {
    }
    
    /// Starts child flow controller.
    public func startChildFlow(_ flowController: FlowController) {
        childControllers.append(flowController)
        flowController.parentController = self
        flowController.start()
    }
    
    /// Stops child flow controller. Must be called when returning to parent flow controller.
    public func stopChildFlow() {
        parentController?.removeChild(self)
    }
    
    private func removeChild(_ flowController: FlowController) {
        if let index = childControllers.index(where: { $0 === flowController }) {
            childControllers.remove(at: index)
        }
    }
    
}
