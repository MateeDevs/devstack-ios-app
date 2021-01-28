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
        let sharedVm = CounterSharedViewModel(dependencies: dependencies)
        let controlVc = setupCounterControl(sharedVm: sharedVm)
        let displayVc = setupCounterDisplay(sharedVm: sharedVm)
        let counterVc = CounterViewController.instantiate(controlVc: controlVc, displayVc: displayVc)
        return counterVc
    }

    private func setupCounterControl(sharedVm: CounterSharedViewModel) -> CounterControlViewController {
        let vm = CounterControlViewModel(dependencies: dependencies)
        let vc = CounterControlViewController.instantiate(controlVm: vm, sharedVm: sharedVm)
        vc.flowDelegate = self
        return vc
    }

    private func setupCounterDisplay(sharedVm: CounterSharedViewModel) -> CounterDisplayViewController {
        let vm = CounterDisplayViewModel(dependencies: dependencies)
        let vc = CounterDisplayViewController.instantiate(displayVm: vm, sharedVm: sharedVm)
        vc.flowDelegate = self
        return vc
    }

}
