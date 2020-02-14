// 
//  RegistrationViewController.swift
//  DevStack
//
//  Created by Petr Chmelar on 05/03/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import UIKit
import RxSwift

protocol RegistrationFlowDelegate: class {
    func popRegistration()
}

final class RegistrationViewController: InputViewController {

    // MARK: FlowDelegate
    weak var flowDelegate: RegistrationFlowDelegate?

    // MARK: ViewModels
    var viewModel: RegistrationViewModel!

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

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .default
    }

    // MARK: Default methods
    override func setupViewModel() {
        super.setupViewModel()

        let input = RegistrationViewModel.Input(email: emailTextField.textField.rx.text.orEmpty.asDriver(),
                                                password: passwordTextField.textField.rx.text.orEmpty.asDriver(),
                                                registerButtonTaps: registerButton.rx.tap.asSignal())
        let output = viewModel.transform(input: input)

        output.registrationEvent.drive(onNext: { [weak self] event in
            if event.isLoading {
                self?.showWhisper(message: L10n.signing_up)
            } else if let error = event.error {
                self?.showWhisperWithError(error)
            } else {
                self?.hideWhisper()
                self?.flowDelegate?.popRegistration()
            }
        }).disposed(by: disposeBag)

        output.registerButtonEnabled.drive(onNext: { [weak self] enabled in
            self?.registerButton.isEnabled = enabled
        }).disposed(by: disposeBag)

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
