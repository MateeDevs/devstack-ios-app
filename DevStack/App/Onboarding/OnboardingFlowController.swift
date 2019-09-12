//
//  OnboardingFlowController.swift
//  DevStack
//
//  Created by Petr Chmelar on 04/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import UIKit

protocol OnboardingFlowControllerDelegate: class {
    func setupMain()
}

class OnboardingFlowController: FlowController, LoginFlowDelegate, RegistrationFlowDelegate {
    
    weak var delegate: OnboardingFlowControllerDelegate?
    
    override func start() {
        super.start()
        let vm = LoginViewModel(dependencies: dependencies)
        let vc = LoginViewController.instantiate(viewModel: vm)
        vc.flowDelegate = self
        navigationController.viewControllers = [vc]
        navigationController.navigationBar.isHidden = true
    }
    
    func dismiss() {
        delegate?.setupMain()
        navigationController.dismiss(animated: true, completion: nil)
        stopChildFlow()
    }
    
    func showRegistration() {
        let vm = RegistrationViewModel(dependencies: dependencies)
        let vc = RegistrationViewController.instantiate(viewModel: vm)
        vc.flowDelegate = self
        navigationController.show(vc, sender: nil)
    }
    
    func popRegistration() {
        navigationController.popViewController(animated: true)
    }
}
