// 
//  ProfileFlowController.swift
//  DevStack
//
//  Created by Petr Chmelar on 06/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import UIKit

protocol ProfileFlowControllerDelegate: class {
    func presentOnboarding()
}

class ProfileFlowController: FlowController, ProfileFlowDelegate, SettingsFlowDelegate {
    
    weak var delegate: ProfileFlowControllerDelegate?
    
    override func start() {
        super.start()
        
        guard let userId = KeychainStore.get(.userId) else { return }
        let profileVm = UserDetailViewModel(dependencies: dependencies, userId: userId)
        let profileVc = ProfileViewController.instantiate(viewModel: profileVm)
        profileVc.flowDelegate = self
        
        let settingsVc = SettingsViewController.instantiate()
        settingsVc.flowDelegate = self
        
        let wrapperVc = ProfileWrapperViewController.instantiate(viewControllers: [profileVc, settingsVc])
        navigationController.viewControllers = [wrapperVc]
    }
    
    func presentOnboarding() {
        delegate?.presentOnboarding()
    }
    
}
