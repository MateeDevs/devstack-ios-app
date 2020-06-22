//
//  RegistrationViewController.swift
//  DevStack
//
//  Created by Petr Chmelar on 05/03/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import RxSwift
import UIKit

protocol RegistrationFlowDelegate: class {
    func popRegistration()
}

final class RegistrationViewController: InputViewController {

    // MARK: FlowDelegate
    weak var flowDelegate: RegistrationFlowDelegate?

    // MARK: ViewModels
    var viewModel: RegistrationViewModel! // swiftlint:disable:this implicitly_unwrapped_optional

    // MARK: UI components
    @IBOutlet private weak var emailTextField: TextFieldWithHint!
    @IBOutlet private weak var passwordTextField: TextFieldWithHint!
    @IBOutlet private weak var registerButton: PrimaryButton!
    @IBOutlet private weak var loginButton: SecondaryButton!

    // MARK: Stored properties

    // MARK: Inits
    static func instantiate(viewModel: RegistrationViewModel) -> RegistrationViewController {
        let vc = StoryboardScene.Registration.initialScene.instantiate()
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
        
        emailTextField.textField.rx.text.orEmpty.bind(to: viewModel.input.email).disposed(by: disposeBag)
        passwordTextField.textField.rx.text.orEmpty.bind(to: viewModel.input.password).disposed(by: disposeBag)
        registerButton.rx.tap.bind(to: viewModel.input.registerButtonTaps).disposed(by: disposeBag)
        
        viewModel.output.registrationSuccess.drive(onNext: { [weak self] _ in
            self?.flowDelegate?.popRegistration()
        }).disposed(by: disposeBag)
        
        viewModel.output.whisperAction.drive(self.rx.whisperAction).disposed(by: disposeBag)
        
        viewModel.output.registerButtonEnabled.drive(loginButton.rx.isEnabled).disposed(by: disposeBag)
        
        loginButton.rx.tap.bind { [weak self] in
            self?.flowDelegate?.popRegistration()
        }.disposed(by: disposeBag)
    }

    override func setupUI() {
        super.setupUI()
        
        emailTextField.textField.keyboardType = .emailAddress
        passwordTextField.textField.keyboardType = .asciiCapable
    }

    // MARK: Additional methods

}
