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
    func presentOnboarding()
}

final class ProfileViewController: BaseViewController {

    // MARK: FlowDelegate
    weak var flowDelegate: ProfileFlowDelegate?

    // MARK: ViewModels
    private var userViewModel: UserDetailViewModel!
    private var logoutViewModel: LogoutViewModel!

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
    static func instantiate(userViewModel: UserDetailViewModel, logoutViewModel: LogoutViewModel) -> ProfileViewController {
        let vc = StoryboardScene.Profile.initialScene.instantiate()
        vc.userViewModel = userViewModel
        vc.logoutViewModel = logoutViewModel
        return vc
    }

    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Default methods
    override func setupViewModel() {
        super.setupViewModel()
        
        // UserViewModel
        let userViewModelInput = UserDetailViewModel.Input()
        let userViewModelOutput = userViewModel.transform(input: userViewModelInput)
        
        userViewModelOutput.getUserDetailEvent.drive(onNext: { [weak self] event in
            if let userDetail = event.data {
                self?.user = userDetail
            }
        }).disposed(by: disposeBag)
        
        // LogoutViewModel
        let logoutViewModelInput = LogoutViewModel.Input(logoutButtonTaps: logoutButton.rx.tap.asSignal())
        let logoutViewModelOutput = logoutViewModel.transform(input: logoutViewModelInput)
        
        logoutViewModelOutput.logoutEvent.drive(onNext: { [weak self] event in
            self?.flowDelegate?.presentOnboarding()
        }).disposed(by: disposeBag)
    }

    override func setupUI() {
        super.setupUI()
        
        navigationItem.title = L10n.profileViewToolbarTitle
    }
    
}
