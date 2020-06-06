// 
//  UserDetailViewController.swift
//  DevStack
//
//  Created by Petr Chmelar on 28/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
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
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var userImageView: UserImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    
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
    override func setupBindings() {
        super.setupBindings()
        
        viewModel.output.getUser.drive(onNext: { [weak self] user in
            self?.user = user
        }).disposed(by: disposeBag)
        
        viewModel.output.downloadUser.drive(onNext: { [weak self] lce in
            switch lce {
            case .loading:
                break
            case .content, .error:
                self?.scrollView.refreshControl?.endRefreshing()
            }
        }).disposed(by: disposeBag)
        
        scrollView.refreshControl?.rx.controlEvent(.valueChanged).bind(to: viewModel.input.refreshTrigger).disposed(by: disposeBag)
        
        viewModel.input.refreshTrigger.onNext(())
    }

    override func setupUI() {
        super.setupUI()
        
        scrollView.addRefreshControl()
        navigationItem.title = L10n.user_detail_view_toolbar_title
    }

    // MARK: Additional methods

}
