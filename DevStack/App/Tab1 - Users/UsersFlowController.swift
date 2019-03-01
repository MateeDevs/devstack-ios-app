//
//  UsersFlowController.swift
//  DevStack
//
//  Created by Petr Chmelar on 28/01/2019.
//  Copyright © 2019 Qest. All rights reserved.
//

import UIKit

class UsersFlowController: FlowController, UsersFlowDelegate, UserDetailFlowDelegate {
    
    override func start() {
        super.start()
        let vm = UsersViewModel(dependencies: dependencies)
        let vc = UsersViewController.instantiate(viewModel: vm)
        vc.flowDelegate = self
        navigationController.viewControllers = [vc]
    }
    
    func showUserDetail(userId: String) {
        let vm = UserDetailViewModel(dependencies: dependencies)
        let vc = UserDetailViewController.instantiate(viewModel: vm, userId: userId)
        vc.flowDelegate = self
        navigationController.show(vc, sender: nil)
    }
    
}
