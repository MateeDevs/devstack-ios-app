// 
//  UserDetailViewController.swift
//  DevStack
//
//  Created by Petr Chmelar on 28/02/2019.
//  Copyright © 2019 Qest. All rights reserved.
//

import UIKit
import RxSwift

protocol UserDetailFlowDelegate: class {

}

final class UserDetailViewController: BaseViewController {

    // MARK: FlowDelegate
    weak var flowDelegate: UserDetailFlowDelegate?

    // MARK: ViewModels
    private var viewModel: UserDetailViewModel!

    // MARK: UI components

    // MARK: Stored properties
    private var userId: String!
    
    // MARK: Inits
    static func instantiate(viewModel: UserDetailViewModel, userId: String) -> UserDetailViewController {
        let vc = StoryboardScene.UserDetail.initialScene.instantiate()
        vc.viewModel = viewModel
        vc.userId = userId
        return vc
    }

    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(userId)
    }

    // MARK: Default methods
    override func setupViewModel() {
        super.setupViewModel()
    }

    override func setupViewAppearance() {
        super.setupViewAppearance()
    }

    // MARK: Additional methods

}
