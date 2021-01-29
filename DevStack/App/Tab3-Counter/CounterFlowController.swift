//
//  CounterFlowController.swift
//  DevStack
//
//  Created by Petr Chmelar on 28.01.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import UIKit

protocol CounterFlowControllerDelegate: class {
}

class CounterFlowController: FlowController, CounterFlowDelegate, CounterControlFlowDelegate, CounterDisplayFlowDelegate {

    override func setup() -> UIViewController {
        let sharedVM = CounterSharedViewModel(dependencies: dependencies)
        let controlVC = setupCounterControl(sharedVM: sharedVM)
        let displayVC = setupCounterDisplay(sharedVM: sharedVM)
        return CounterViewController.instantiate(controlVC: controlVC, displayVC: displayVC)
    }

    private func setupCounterControl(sharedVM: CounterSharedViewModel) -> CounterControlViewController {
        let vm = CounterControlViewModel(dependencies: dependencies)
        let vc = CounterControlViewController.instantiate(controlVM: vm, sharedVM: sharedVM)
        vc.flowDelegate = self
        return vc
    }

    private func setupCounterDisplay(sharedVM: CounterSharedViewModel) -> CounterDisplayViewController {
        let vm = CounterDisplayViewModel(dependencies: dependencies)
        let vc = CounterDisplayViewController.instantiate(displayVM: vm, sharedVM: sharedVM)
        vc.flowDelegate = self
        return vc
    }

}
