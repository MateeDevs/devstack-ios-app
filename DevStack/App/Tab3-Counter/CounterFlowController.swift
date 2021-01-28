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
        let counterControlVm = CounterControlViewModel(dependencies: dependencies)
        let counterControlVc = CounterControlViewController.instantiate(viewModel: counterControlVm)
        counterControlVc.flowDelegate = self

        let counterDisplayVm = CounterDisplayViewModel(dependencies: dependencies)
        let counterDisplayVc = CounterDisplayViewController.instantiate(viewModel: counterDisplayVm)
        counterDisplayVc.flowDelegate = self

        let counterVc = CounterViewController.instantiate(
            controlViewController: counterControlVc,
            displayViewController: counterDisplayVc
        )
        return counterVc
    }

}
