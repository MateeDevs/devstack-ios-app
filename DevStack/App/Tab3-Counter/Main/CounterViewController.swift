//
//  CounterViewController.swift
//  DevStack
//
//  Created by Petr Chmelar on 28.01.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift
import UIKit

protocol CounterFlowDelegate: class {

}

final class CounterViewController: BaseViewController {

    // MARK: FlowDelegate
    weak var flowDelegate: CounterFlowDelegate?

    // MARK: ViewModels

    // MARK: UI components
    @IBOutlet private weak var controlView: UIView!
    @IBOutlet private weak var displayView: UIView!

    // MARK: Stored properties
    private var controlViewController: CounterControlViewController! // swiftlint:disable:this implicitly_unwrapped_optional
    private var displayViewController: CounterDisplayViewController! // swiftlint:disable:this implicitly_unwrapped_optional

    // MARK: Inits
    static func instantiate(controlVc: CounterControlViewController, displayVc: CounterDisplayViewController) -> CounterViewController {
        let vc = StoryboardScene.Counter.initialScene.instantiate()
        vc.controlViewController = controlVc
        vc.displayViewController = displayVc
        return vc
    }

    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Add child view controllers
        add(controlViewController)
        add(displayViewController)
    }

    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // Set frames for child view controllers
        controlViewController.view.frame = controlView.frame
        displayViewController.view.frame = displayView.frame
    }

    // MARK: Default methods
    override func setupBindings() {
        super.setupBindings()
    }

    override func setupUI() {
        super.setupUI()

        navigationItem.title = L10n.counter_view_toolbar_title
    }

    // MARK: Additional methods

}
