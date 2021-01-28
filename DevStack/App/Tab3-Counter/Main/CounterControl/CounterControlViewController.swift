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
    private var viewModel: CounterControlViewModel! // swiftlint:disable:this implicitly_unwrapped_optional

    // MARK: UI components
    @IBOutlet private weak var increaseButton: SecondaryButton!
    @IBOutlet private weak var decreaseButton: SecondaryButton!
    @IBOutlet private weak var hideButton: SecondaryButton!

    // MARK: Stored properties

    // MARK: Inits
    static func instantiate(viewModel: CounterControlViewModel) -> CounterControlViewController {
        let vc = StoryboardScene.CounterControl.initialScene.instantiate()
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
        increaseButton.rx.tap.bind(to: viewModel.input.increaseButtonTaps).disposed(by: disposeBag)
        decreaseButton.rx.tap.bind(to: viewModel.input.decreaseButtonTaps).disposed(by: disposeBag)

        // Outputs
        viewModel.output.increaseCounter.drive().disposed(by: disposeBag)
        viewModel.output.decreaseCounter.drive().disposed(by: disposeBag)
    }

    override func setupUI() {
        super.setupUI()
    }

    // MARK: Additional methods

}

extension CounterControlViewController {
    /// Reactive wrapper for `hideButton.tap` property.
    var hideButtonTap: ControlEvent<Void> {
        return hideButton.rx.tap
    }
}
