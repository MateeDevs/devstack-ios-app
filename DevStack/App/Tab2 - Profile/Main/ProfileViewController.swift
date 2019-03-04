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
    private var profileViewModel: ProfileViewModel!

    // MARK: UI components
    @IBOutlet weak var userImageView: UserImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    // MARK: Stored properties
    private var user: User? {
        didSet {
            userImageView.setupWithUser(user)
            userNameLabel.text = user?.fullName
        }
    }
    
    // MARK: Inits
    static func instantiate(userViewModel: UserDetailViewModel, profileViewModel: ProfileViewModel) -> ProfileViewController {
        let vc = StoryboardScene.Profile.initialScene.instantiate()
        vc.userViewModel = userViewModel
        vc.profileViewModel = profileViewModel
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
        let output = userViewModel.transform(input: input)
        
        output.getUserDetailEvent.drive(onNext: { [weak self] (event) in
            if let userDetail = event.data {
                self?.user = userDetail
            }
        }).disposed(by: disposeBag)
    }

    override func setupViewAppearance() {
        super.setupViewAppearance()
        
        navigationItem.title = L10n.profileViewToolbarTitle
    }

    // MARK: Additional methods
    @IBAction func loginButtonTouchUpInside(_ sender: EnhancedButton) {
        profileViewModel.logout()
        flowDelegate?.presentOnboarding()
    }
    
}
