//
//  AppFlowController.swift
//  DevStack
//
//  Created by Petr Chmelar on 17/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

class AppFlowController: FlowController, MainFlowControllerDelegate, OnboardingFlowControllerDelegate {
    
    func start() {
        if dependencies.userRepository.getProfileId() != nil {
            setupMain()
        } else {
            presentOnboarding(animated: false, completion: nil)
        }
    }
    
    func setupMain() {
        let fc = MainFlowController(navigationController: navigationController, dependencies: dependencies)
        fc.delegate = self
        let rootVC = startChildFlow(fc)
        navigationController.navigationBar.barStyle = .black
        navigationController.viewControllers = [rootVC]
    }
    
    func presentOnboarding(animated: Bool, completion: (() -> Void)?) {
        let nc = UINavigationController()
        let fc = OnboardingFlowController(navigationController: nc, dependencies: dependencies)
        fc.delegate = self
        let rootVC = startChildFlow(fc)
        nc.viewControllers = [rootVC]
        nc.modalPresentationStyle = .fullScreen
        nc.navigationBar.isHidden = true
        navigationController.present(nc, animated: animated, completion: completion)
    }
    
    func handleDeeplink(for notification: PushNotification) {
        guard let main = childControllers.first(where: { $0 is MainFlowController }) as? MainFlowController else { return }
        main.handleDeeplink(for: notification)
    }
}
