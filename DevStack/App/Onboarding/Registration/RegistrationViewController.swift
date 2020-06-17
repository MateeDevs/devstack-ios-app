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

    // MARK: Default methods
    override func setupBindings() {
        super.setupBindings()
        
        emailTextField.textField.rx.text.orEmpty.bind(to: viewModel.input.email).disposed(by: disposeBag)
        passwordTextField.textField.rx.text.orEmpty.bind(to: viewModel.input.password).disposed(by: disposeBag)
        registerButton.rx.tap.bind(to: viewModel.input.registerButtonTaps).disposed(by: disposeBag)
        
        viewModel.output.registration.drive(onNext: { [weak self] event in
            switch event {
            case .loading:
                self?.showWhisper(message: L10n.signing_up)
                self?.registerButton.isEnabled = false
            case .content:
                self?.hideWhisper()
                self?.registerButton.isEnabled = true
                self?.flowDelegate?.popRegistration()
            case .error(let error):
                self?.showWhisperWithError(error)
                self?.registerButton.isEnabled = true
            }
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
