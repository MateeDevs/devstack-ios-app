// 
//  LocationDetailViewController.swift
//  DevStack
//
//  Created by Filip Bodnár on 12/02/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import UIKit
import RxSwift

protocol LocationDetailFlowDelegate: class {

}

final class LocationDetailViewController: BaseViewController {

    // MARK: FlowDelegate
    weak var flowDelegate: LocationDetailFlowDelegate?

    // MARK: ViewModels
    private var viewModel: LocationDetailViewModel!

    // MARK: UI components

    // MARK: Stored properties

    // MARK: Inits
    static func instantiate(viewModel: LocationDetailViewModel) -> LocationDetailViewController {
        let vc = StoryboardScene.LocationDetail.initialScene.instantiate()
        vc.viewModel = viewModel
        return vc
    }

    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Default methods
    override func setupViewModel() {
        super.setupViewModel()
    }

    override func setupUI() {
        super.setupUI()
    }

    // MARK: Additional methods

}
