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
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var smallButton: UIButton!
    @IBOutlet weak var largeButton: UIButton!
    
    // MARK: Stored properties

    // MARK: Inits
    static func instantiate() -> SettingsViewController {
        let vc = StoryboardScene.Settings.initialScene.instantiate()
        return vc
    }

    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

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

    override func setupUI() {
        super.setupUI()
    }

    // MARK: Additional methods

}
