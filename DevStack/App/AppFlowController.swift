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
        if KeychainStore.get(.userId) != nil {
            setupMain()
        } else {
            presentOnboarding()
        }
    }
    
    func setupMain() {
        let fc = MainFlowController(navigationController: navigationController, dependencies: dependencies)
        fc.delegate = self
        let rootVc = startChildFlow(fc)
        navigationController.navigationBar.barStyle = .black
        navigationController.viewControllers = [rootVc]
    }
    
    func presentOnboarding() {
        let nc = UINavigationController()
        let fc = OnboardingFlowController(navigationController: nc, dependencies: dependencies)
        fc.delegate = self
        let rootVc = startChildFlow(fc)
        nc.viewControllers = [rootVc]
        nc.modalPresentationStyle = .fullScreen
        nc.navigationBar.isHidden = true
        navigationController.present(nc, animated: true, completion: nil)
    }
    
    func handleDeeplink(for notification: PushNotification) {
        guard let main = childControllers.first as? MainFlowController else { return }
        main.handleDeeplink(for: notification)
    }
}
