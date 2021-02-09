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

enum ProfileViewControllerFlow {
    case presentOnboarding
}

final class ProfileViewController: BaseViewController {

    // MARK: FlowController
    private weak var flowController: ProfileFlowController?

    // MARK: ViewModels
    private var viewModel: ProfileViewModel?

    // MARK: UI components
    @IBOutlet private weak var userImageView: UserImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var logoutButton: PrimaryButton!
    
    // MARK: Stored properties
    
    // MARK: Inits
    static func instantiate(fc: ProfileFlowController, vm: ProfileViewModel) -> ProfileViewController {
        let vc = StoryboardScene.Profile.initialScene.instantiate()
        vc.flowController = fc
        vc.viewModel = vm
        return vc
    }

    // MARK: Lifecycle methods

    // MARK: Default methods
    override func setupBindings() {
        super.setupBindings()
        
        guard let viewModel = viewModel, let flowController = flowController else { return }

        // Inputs
        logoutButton.rx.tap.bind(to: viewModel.input.logoutButtonTaps).disposed(by: disposeBag)

        // Outputs
        viewModel.output.profile.fullName.drive(userNameLabel.rx.text).disposed(by: disposeBag)
        viewModel.output.profile.initials.drive(userImageView.rx.initials).disposed(by: disposeBag)
        viewModel.output.profile.imageURL.drive(userImageView.rx.imageURL).disposed(by: disposeBag)
        
        viewModel.output.isRefreshing.drive(view.rx.skeletonView).disposed(by: disposeBag)
        
        viewModel.output.currentLocation
            .map { $0.coordinate.toString() }
            .drive(locationLabel.rx.text).disposed(by: disposeBag)

        viewModel.output.flow.drive(flowController.rx.handleProfileFlow).disposed(by: disposeBag)
    }

    override func setupUI() {
        super.setupUI()
        
        view.isSkeletonable = true
        userImageView.isSkeletonable = true
        userNameLabel.isSkeletonable = true
    }
    
}
