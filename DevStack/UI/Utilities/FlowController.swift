//
//  FlowController.swift
//  DevStack
//
//  Created by Petr Chmelar on 06/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import UIKit

open class FlowController: NSObject {
    
    public let navigationController: UINavigationController
    public let dependencies: AppDependency
    
    private weak var parentController: FlowController?
    private(set) var childControllers: [FlowController] = []
    
    private(set) var rootViewController: UIViewController?
    
    public init(navigationController: UINavigationController, dependencies: AppDependency) {
        self.navigationController = navigationController
        self.dependencies = dependencies
        Logger.info("%@ initialized", "\(type(of: self))", category: .lifecycle)
    }
    
    deinit {
        Logger.info("%@ deinitialized", "\(type(of: self))", category: .lifecycle)
    }
    
    /// Override this method in a subclass and return initial ViewController of the flow.
    open func setup() -> UIViewController {
        UIViewController()
    }
    
    /// Default implementation for dismissing a modal flow. Override in a subclass if you want a custom behavior.
    open func dismiss() {
        navigationController.dismiss(animated: true, completion: { [weak self] in
            self?.stopFlow()
        })
    }
    
    /// Starts child flow controller and returns initial ViewController.
    public func startChildFlow(_ flowController: FlowController) -> UIViewController {
        childControllers.append(flowController)
        flowController.parentController = self
        flowController.navigationController.delegate = flowController
        flowController.rootViewController = flowController.setup()
        return flowController.rootViewController ?? UIViewController()
    }
    
    /// Stops flow controller. Must be called when returning to a parent flow controller.
    public func stopFlow() {
        parentController?.removeChild(self)
    }
    
    private func removeChild(_ flowController: FlowController) {
        if let index = childControllers.firstIndex(where: { $0 === flowController }) {
            childControllers.remove(at: index)
        }
    }
    
}

extension FlowController: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // Stop a child flow controller when returning to a parent flow controller via back button
        // Idea taken from [Back Buttons and Coordinators](http://khanlou.com/2017/05/back-buttons-and-coordinators/)
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(fromViewController),
            fromViewController == rootViewController else { return }
        stopFlow()
    }
}
