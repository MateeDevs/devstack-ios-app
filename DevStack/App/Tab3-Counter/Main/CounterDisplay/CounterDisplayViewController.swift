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
    private var viewModel: CounterDisplayViewModel! // swiftlint:disable:this implicitly_unwrapped_optional

    // MARK: UI components
    @IBOutlet private weak var counterLabel: UILabel!

    // MARK: Stored properties

    // MARK: Inits
    static func instantiate(viewModel: CounterDisplayViewModel) -> CounterDisplayViewController {
        let vc = StoryboardScene.CounterDisplay.initialScene.instantiate()
        vc.viewModel = viewModel
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
        viewModel.output.counterValue.drive(counterLabel.rx.text).disposed(by: disposeBag)
    }

    override func setupUI() {
        super.setupUI()
    }

    // MARK: Additional methods
    private func hideCounterLabel() {
        counterLabel.isHidden = !counterLabel.isHidden
    }
}

extension CounterDisplayViewController {
    /// Bindable sink for `hideCounterLabel()` method
    var counterLabelIsHidden: Binder<Void> {
        return Binder(self) { base, _ in
            base.hideCounterLabel()
        }
    }
}
