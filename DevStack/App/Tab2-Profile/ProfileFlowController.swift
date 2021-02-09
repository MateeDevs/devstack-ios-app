//
//  ProfileFlowController.swift
//  DevStack
//
//  Created by Petr Chmelar on 06/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

protocol ProfileFlowControllerDelegate: class {
    func presentOnboarding()
}

class ProfileFlowController: FlowController {
    
    weak var delegate: ProfileFlowControllerDelegate?
    
    override func setup() -> UIViewController {
        let profileVM = ProfileViewModel(dependencies: dependencies)
        let profileVC = ProfileViewController.instantiate(fc: self, vm: profileVM)
        let settingsVC = SettingsViewController.instantiate(fc: self)
        return ProfileWrapperViewController.instantiate(viewControllers: [profileVC, settingsVC])
    }
}

// MARK: Profile flow
extension ProfileFlowController {
    func handleProfileFlow(_ flow: ProfileViewControllerFlow) {
        switch flow {
        case .presentOnboarding: presentOnboarding()
        }
    }
    
    private func presentOnboarding() {
        delegate?.presentOnboarding()
    }
}

// MARK: Reactive extensions
extension Reactive where Base: ProfileFlowController {
    /// Bindable sink for `handleProfileFlow` method
    var handleProfileFlow: Binder<ProfileViewControllerFlow> {
        Binder(self.base) { base, flow in
            base.handleProfileFlow(flow)
        }
    }
}
