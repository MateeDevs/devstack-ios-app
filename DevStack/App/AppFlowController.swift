//
//  AppFlowController.swift
//  DevStack
//
//  Created by Petr Chmelar on 17/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

class AppFlowController: FlowController, MainFlowControllerDelegate, OnboardingFlowControllerDelegate {
    
    override func start() {
        super.start()
        if KeychainStore.get(.userId) != nil {
            setupMain()
        } else {
            presentOnboarding()
        }
    }
    
    func setupMain() {
        let fc = MainFlowController(navigationController: navigationController, dependencies: dependencies)
        fc.delegate = self
        startChildFlow(fc)
    }
    
    func presentOnboarding() {
        let nc = UINavigationController()
        let fc = OnboardingFlowController(navigationController: nc, dependencies: dependencies)
        nc.modalPresentationStyle = .fullScreen
        navigationController.present(nc, animated: true, completion: nil)
        fc.delegate = self
        startChildFlow(fc)
    }
}
