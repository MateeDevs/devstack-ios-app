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
    
    override func setup() -> UIViewController {
        let profileVM = ProfileViewModel(dependencies: dependencies)
        let profileVC = ProfileViewController.instantiate(viewModel: profileVM)
        profileVC.flowDelegate = self
        
        let settingsVC = SettingsViewController.instantiate()
        settingsVC.flowDelegate = self
        
        return ProfileWrapperViewController.instantiate(viewControllers: [profileVC, settingsVC])
    }
    
    func presentOnboarding() {
        delegate?.presentOnboarding()
    }
    
}
