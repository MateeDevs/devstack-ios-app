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
    
    var flowDelegate: OnboardingFlowDelegate?
    
    override func start() {
        super.start()
        let vc = StoryboardScene.Login.initialScene.instantiate()
        vc.viewModel = LoginViewModel(dependencies: dependencies)
        vc.flowDelegate = self
        navigationController.navigationBar.isHidden = true
        navigationController.viewControllers = [vc]
        UIApplication.shared.statusBarView?.backgroundColor = Asset.Colors.mainBackground.color
    }
    
    func popToMain() {
        flowDelegate?.setupMain()
        navigationController.dismiss(animated: true, completion: nil)
        UIApplication.shared.statusBarView?.backgroundColor = ColorTheme.mainColor
    }
}
