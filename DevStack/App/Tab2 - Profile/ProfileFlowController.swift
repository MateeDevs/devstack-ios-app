// 
//  ProfileFlowController.swift
//  DevStack
//
//  Created by Petr Chmelar on 06/02/2019.
//  Copyright © 2019 Qest. All rights reserved.
//

import UIKit

class ProfileFlowController: FlowController, ProfileFlowDelegate {
    
    override func start() {
        super.start()
        let vm = ProfileViewModel(dependencies: dependencies)
        let vc = ProfileViewController.instantiate(viewModel: vm)
        vc.flowDelegate = self
        navigationController.viewControllers = [vc]
    }
    
}
