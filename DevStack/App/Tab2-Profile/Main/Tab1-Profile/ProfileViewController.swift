//
//  ProfileViewController.swift
//  DevStack
//
//  Created by Petr Chmelar on 06/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

protocol ProfileFlowDelegate: class {
    func presentOnboarding()
}

final class ProfileViewController: BaseViewController {

    // MARK: FlowDelegate
    weak var flowDelegate: ProfileFlowDelegate?

    // MARK: ViewModels
    private var viewModel: ProfileViewModel! // swiftlint:disable:this implicitly_unwrapped_optional

    // MARK: UI components
    @IBOutlet private weak var userImageView: UserImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var logoutButton: PrimaryButton!
    
    // MARK: Stored properties
    private var user: User? {
        didSet {
            userImageView.setupWithUser(user)
            userNameLabel.text = user?.fullName
        }
    }
    
    // MARK: Inits
    static func instantiate(viewModel: ProfileViewModel) -> ProfileViewController {
        let vc = StoryboardScene.Profile.initialScene.instantiate()
        vc.viewModel = viewModel
        return vc
    }

    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Default methods
    override func setupBindings() {
        super.setupBindings()
        
        viewModel.output.profile.drive(onNext: { [weak self] user in
            self?.user = user
        }).disposed(by: disposeBag)
        
        viewModel.output.isRefreshing.drive(view.rx.skeletonView).disposed(by: disposeBag)
        
        viewModel.output.currentLocation
            .map { $0.coordinate.toString() }
            .drive(locationLabel.rx.text).disposed(by: disposeBag)
        
        logoutButton.rx.tap.bind { [weak self] in
            LoginService.logout()
            self?.flowDelegate?.presentOnboarding()
        }.disposed(by: disposeBag)
    }

    override func setupUI() {
        super.setupUI()
        view.isSkeletonable = true
        userImageView.isSkeletonable = true
        userNameLabel.isSkeletonable = true
    }
    
}
