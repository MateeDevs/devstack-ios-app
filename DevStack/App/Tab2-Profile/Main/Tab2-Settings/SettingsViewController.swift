//
//  SettingsViewController.swift
//  DevStack
//
//  Created by Petr Chmelar on 20/04/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import RxSwift
import UIKit

protocol SettingsFlowDelegate: class {

}

final class SettingsViewController: BaseViewController {

    // MARK: FlowDelegate
    weak var flowDelegate: SettingsFlowDelegate?

    // MARK: ViewModels

    // MARK: UI components
    @IBOutlet private weak var topViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var smallButton: UIButton!
    @IBOutlet private weak var largeButton: UIButton!
    
    // MARK: Stored properties

    // MARK: Inits
    static func instantiate() -> SettingsViewController {
        StoryboardScene.Settings.initialScene.instantiate()
    }

    // MARK: Lifecycle methods

    // MARK: Default methods
    override func setupBindings() {
        super.setupBindings()
        
        smallButton.rx.tap.bind { [weak self] in
            self?.topViewHeightConstraint.constant = 300.0
        }.disposed(by: disposeBag)
        
        largeButton.rx.tap.bind { [weak self] in
            self?.topViewHeightConstraint.constant = 1200.0
        }.disposed(by: disposeBag)
    }

    // MARK: Additional methods

}
