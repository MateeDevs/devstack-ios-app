//
//  LoginViewController.swift
//  DevStack
//
//  Created by Petr Chmelar on 04/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import RxSwift
import UIKit

protocol LoginFlowDelegate: class {
    func dismiss()
    func showRegistration()
}

final class LoginViewController: InputViewController {
    
    // MARK: FlowDelegate
    weak var flowDelegate: LoginFlowDelegate?
    
    // MARK: ViewModels
    private var viewModel: LoginViewModel! // swiftlint:disable:this implicitly_unwrapped_optional
    
    // MARK: UI components
    @IBOutlet private weak var emailTextField: TextFieldWithHint! {
        didSet {
            emailTextField.type = .email
        }
    }
    @IBOutlet private weak var passwordTextField: TextFieldWithHint! {
        didSet {
            passwordTextField.type = .password
        }
    }
    @IBOutlet private weak var loginButton: PrimaryButton!
    @IBOutlet private weak var registerButton: SecondaryButton!
    
    // MARK: Stored properties
    
    // MARK: Inits
    static func instantiate(viewModel: LoginViewModel) -> LoginViewController {
        let vc = StoryboardScene.Login.initialScene.instantiate()
        vc.viewModel = viewModel
        return vc
    }
    
    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        #if ALPHA
        emailTextField.textField.text = "petr.chmelar@matee.cz"
        passwordTextField.textField.text = "11111111"
        #elseif BETA
        emailTextField.textField.text = "petr.chmelar@matee.cz"
        passwordTextField.textField.text = "11111111"
        #endif
    }
    
    // MARK: Default methods
    override func setupBindings() {
        super.setupBindings()

        // Inputs
        emailTextField.rx.text.bind(to: viewModel.input.email).disposed(by: disposeBag)
        passwordTextField.rx.text.bind(to: viewModel.input.password).disposed(by: disposeBag)
        loginButton.rx.tap.bind(to: viewModel.input.loginButtonTaps).disposed(by: disposeBag)

        // Outputs
        viewModel.output.loginButtonEnabled.drive(loginButton.rx.isEnabled).disposed(by: disposeBag)
        viewModel.output.alertAction.drive(rx.alertAction).disposed(by: disposeBag)
        viewModel.output.loginSuccess.drive(onNext: { [weak self] _ in
            self?.flowDelegate?.dismiss()
        }).disposed(by: disposeBag)

        // Other
        registerButton.rx.tap.bind { [weak self] in
            self?.flowDelegate?.showRegistration()
        }.disposed(by: disposeBag)
    }

    // MARK: Additional methods

}
