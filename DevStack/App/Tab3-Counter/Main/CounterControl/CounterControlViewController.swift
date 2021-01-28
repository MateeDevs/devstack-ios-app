//
//  CounterControlViewController.swift
//  DevStack
//
//  Created by Petr Chmelar on 28.01.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

protocol CounterControlFlowDelegate: class {

}

final class CounterControlViewController: BaseViewController {

    // MARK: FlowDelegate
    weak var flowDelegate: CounterControlFlowDelegate?

    // MARK: ViewModels
    private var controlViewModel: CounterControlViewModel! // swiftlint:disable:this implicitly_unwrapped_optional
    private var sharedViewModel: CounterSharedViewModel! // swiftlint:disable:this implicitly_unwrapped_optional

    // MARK: UI components
    @IBOutlet private weak var increaseButton: SecondaryButton!
    @IBOutlet private weak var decreaseButton: SecondaryButton!
    @IBOutlet private weak var hideButton: SecondaryButton!

    // MARK: Stored properties

    // MARK: Inits
    static func instantiate(controlVm: CounterControlViewModel, sharedVm: CounterSharedViewModel) -> CounterControlViewController {
        let vc = StoryboardScene.CounterControl.initialScene.instantiate()
        vc.controlViewModel = controlVm
        vc.sharedViewModel = sharedVm
        return vc
    }

    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Default methods
    override func setupBindings() {
        super.setupBindings()

        // Inputs
        increaseButton.rx.tap.bind(to: controlViewModel.input.increaseButtonTaps).disposed(by: disposeBag)
        decreaseButton.rx.tap.bind(to: controlViewModel.input.decreaseButtonTaps).disposed(by: disposeBag)
        hideButton.rx.isOn.bind(to: sharedViewModel.input.hideButtonIsOn).disposed(by: disposeBag)

        // Outputs
        controlViewModel.output.increaseCounter.drive().disposed(by: disposeBag)
        controlViewModel.output.decreaseCounter.drive().disposed(by: disposeBag)
    }

    override func setupUI() {
        super.setupUI()
    }

    // MARK: Additional methods

}
