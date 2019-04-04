// 
//  ProfileViewController.swift
//  DevStack
//
//  Created by Petr Chmelar on 06/02/2019.
//  Copyright © 2019 Qest. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol ProfileFlowDelegate: class {
    func presentOnboarding()
}

final class ProfileViewController: BaseViewController {

    // MARK: FlowDelegate
    weak var flowDelegate: ProfileFlowDelegate?

    // MARK: ViewModels
    private var viewModel: UserDetailViewModel!

    // MARK: UI components
    @IBOutlet private weak var userImageView: UserImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var logoutButton: BaseButton!
    
    // MARK: Stored properties
    private var user: User? {
        didSet {
            userImageView.setupWithUser(user)
            userNameLabel.text = user?.fullName
        }
    }
    
    // MARK: Inits
    static func instantiate(viewModel: UserDetailViewModel) -> ProfileViewController {
        let vc = StoryboardScene.Profile.initialScene.instantiate()
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
        
        let input = UserDetailViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.getUserDetailEvent.drive(onNext: { [weak self] event in
            if let userDetail = event.data {
                self?.user = userDetail
            }
        }).disposed(by: disposeBag)
        
        logoutButton.rx.tap.bind { [weak self] in
            LoginService.logout()
            self?.flowDelegate?.presentOnboarding()
        }.disposed(by: disposeBag)
    }

    override func setupUI() {
        super.setupUI()
        
        navigationItem.title = L10n.profileViewToolbarTitle
    }
    
}
