// 
//  ProfileViewController.swift
//  DevStack
//
//  Created by Petr Chmelar on 06/02/2019.
//  Copyright © 2019 Qest. All rights reserved.
//

import UIKit
import RxSwift

protocol ProfileFlowDelegate: class {

}

final class ProfileViewController: BaseViewController {

    // MARK: - FlowDelegate
    weak var flowDelegate: ProfileFlowDelegate?

    // MARK: - ViewModels
    var viewModel: ProfileViewModel?

    // MARK: - UI components

    // MARK: - Stored properties

    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Default methods
    override func setupViewModel() {
        super.setupViewModel()
    }

    override func setupViewAppearance() {
        super.setupViewAppearance()
    }

    // MARK: - Additional methods

}
