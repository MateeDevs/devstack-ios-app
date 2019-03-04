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
    @IBOutlet weak var userImageView: UserImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    // MARK: Stored properties
    private var userId: String!
    private var user: User? {
        didSet {
            userImageView.setupWithUser(user)
            userNameLabel.text = user?.fullName
        }
    }
    
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
    }

    // MARK: Default methods
    override func setupViewModel() {
        super.setupViewModel()
        
        let input = UserDetailViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.getUserDetailEvent.drive(onNext: { [weak self] (event) in
            if let userDetail = event.data {
                self?.user = userDetail
            }
        }).disposed(by: disposeBag)
    }

    override func setupViewAppearance() {
        super.setupViewAppearance()
        
        navigationItem.title = L10n.userDetailViewToolbarTitle
    }

    // MARK: Additional methods

}
