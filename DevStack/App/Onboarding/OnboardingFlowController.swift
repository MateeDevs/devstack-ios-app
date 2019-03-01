//
//  OnboardingFlowController.swift
//  DevStack
//
//  Created by Petr Chmelar on 04/02/2019.
//  Copyright © 2019 Qest. All rights reserved.
//

import UIKit

protocol OnboardingFlowDelegate: class {
    func setupMain()
}

class OnboardingFlowController: FlowController, LoginFlowDelegate {
    
    weak var flowDelegate: OnboardingFlowDelegate?
    
    override func start() {
        super.start()
        let vm = LoginViewModel(dependencies: dependencies)
        let vc = LoginViewController.instantiate(viewModel: vm)
        vc.flowDelegate = self
        navigationController.viewControllers = [vc]
        navigationController.navigationBar.isHidden = true
        UIApplication.shared.statusBarView?.backgroundColor = Asset.Colors.mainBackground.color
    }
    
    func popToMain() {
        flowDelegate?.setupMain()
        navigationController.dismiss(animated: true, completion: nil)
        UIApplication.shared.statusBarView?.backgroundColor = ColorTheme.mainColor
        stopChildFlow()
    }
}
