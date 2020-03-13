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
    private var refreshTrigger = PublishSubject<Void>()
    
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
        
        refreshTrigger.bind(to: viewModel.input.refreshTrigger).disposed(by: disposeBag)
        
        viewModel.output.getUserEvent.drive(onNext: { [weak self] event in
            guard let user = event.data else { return }
            self?.user = user
        }).disposed(by: disposeBag)
        
        viewModel.output.downloadUserEvent.drive(onNext: { [weak self] event in
            if !event.isLoading {
                self?.scrollView.refreshControl?.endRefreshing()
            }
        }).disposed(by: disposeBag)
        
        scrollView.refreshControl?.rx.controlEvent(.valueChanged).bind(onNext: { [weak self] in
            self?.refreshTrigger.onNext(())
        }).disposed(by: disposeBag)
        
        refreshTrigger.onNext(())
    }

    override func setupUI() {
        super.setupUI()
        
        scrollView.addRefreshControl()
        navigationItem.title = L10n.user_detail_view_toolbar_title
    }

    // MARK: Additional methods

}
