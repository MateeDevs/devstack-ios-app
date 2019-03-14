// 
//  ProfileFlowController.swift
//  DevStack
//
//  Created by Petr Chmelar on 06/02/2019.
//  Copyright © 2019 Qest. All rights reserved.
//

import UIKit

protocol ProfileFlowControllerDelegate: class {
    func presentOnboarding()
}

class ProfileFlowController: FlowController, ProfileFlowDelegate {
    
    weak var delegate: ProfileFlowControllerDelegate?
    
    override func start() {
        super.start()
        guard let userId = KeychainStore.get(key: KeychainCoding.userId) else { return }
        let userVm = UserDetailViewModel(dependencies: dependencies, userId: userId)
        let logoutVm = LogoutViewModel(dependencies: dependencies)
        let vc = ProfileViewController.instantiate(userViewModel: userVm, logoutViewModel: logoutVm)
        vc.flowDelegate = self
        navigationController.viewControllers = [vc]
    }
    
    func presentOnboarding() {
        delegate?.presentOnboarding()
    }
    
}
