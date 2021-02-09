//
//  OnboardingFlowController.swift
//  DevStack
//
//  Created by Petr Chmelar on 04/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

protocol OnboardingFlowControllerDelegate: class {
    func setupMain()
}

class OnboardingFlowController: FlowController {
    
    weak var delegate: OnboardingFlowControllerDelegate?
    
    override func setup() -> UIViewController {
        let vm = LoginViewModel(dependencies: dependencies)
        let vc = LoginViewController.instantiate(fc: self, vm: vm)
        return vc
    }
    
    override func dismiss() {
        super.dismiss()
        delegate?.setupMain()
    }
}

// MARK: Login flow
extension OnboardingFlowController {
    func handleLoginFlow(_ flow: LoginViewControllerFlow) {
        switch flow {
        case .dismiss: dismiss()
        case .showRegistration: showRegistration()
        }
    }
    
    private func showRegistration() {
        let vm = RegistrationViewModel(dependencies: dependencies)
        let vc = RegistrationViewController.instantiate(fc: self, vm: vm)
        navigationController.show(vc, sender: nil)
    }
}

// MARK: Registration flow
extension OnboardingFlowController {
    func handleRegistrationFlow(_ flow: RegistrationViewControllerFlow) {
        switch flow {
        case .popRegistration: popRegistration()
        }
    }
    
    private func popRegistration() {
        navigationController.popViewController(animated: true)
    }
}

// MARK: Reactive extensions
extension Reactive where Base: OnboardingFlowController {
    /// Bindable sink for `handleLoginFlow` method
    var handleLoginFlow: Binder<LoginViewControllerFlow> {
        Binder(self.base) { base, flow in
            base.handleLoginFlow(flow)
        }
    }
    
    /// Bindable sink for `handleRegistrationFlow` method
    var handleRegistrationFlow: Binder<RegistrationViewControllerFlow> {
        Binder(self.base) { base, flow in
            base.handleRegistrationFlow(flow)
        }
    }
}
