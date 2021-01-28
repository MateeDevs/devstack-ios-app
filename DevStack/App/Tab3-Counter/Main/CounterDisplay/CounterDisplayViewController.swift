//
//  CounterDisplayViewController.swift
//  DevStack
//
//  Created by Petr Chmelar on 28.01.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

protocol CounterDisplayFlowDelegate: class {

}

final class CounterDisplayViewController: BaseViewController {

    // MARK: FlowDelegate
    weak var flowDelegate: CounterDisplayFlowDelegate?

    // MARK: ViewModels
    private var displayViewModel: CounterDisplayViewModel! // swiftlint:disable:this implicitly_unwrapped_optional
    private var sharedViewModel: CounterSharedViewModel! // swiftlint:disable:this implicitly_unwrapped_optional

    // MARK: UI components
    @IBOutlet private weak var counterLabel: UILabel!

    // MARK: Stored properties

    // MARK: Inits
    static func instantiate(displayVm: CounterDisplayViewModel, sharedVm: CounterSharedViewModel) -> CounterDisplayViewController {
        let vc = StoryboardScene.CounterDisplay.initialScene.instantiate()
        vc.displayViewModel = displayVm
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

        // Outputs
        displayViewModel.output.counterValue.drive(counterLabel.rx.text).disposed(by: disposeBag)

        sharedViewModel.output.hideCounterLabel
            .map { !self.counterLabel.isHidden }
            .drive(counterLabel.rx.isHidden).disposed(by: disposeBag)
    }

    override func setupUI() {
        super.setupUI()
    }

    // MARK: Additional methods

}
