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
    @IBOutlet private weak var emailTextField: TextFieldWithHint!
    @IBOutlet private weak var passwordTextField: TextFieldWithHint!
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
        
        emailTextField.textField.rx.text.orEmpty.bind(to: viewModel.input.email).disposed(by: disposeBag)
        passwordTextField.textField.rx.text.orEmpty.bind(to: viewModel.input.password).disposed(by: disposeBag)
        loginButton.rx.tap.bind(to: viewModel.input.loginButtonTaps).disposed(by: disposeBag)
        
        viewModel.output.login.drive(onNext: { [weak self] lce in
            switch lce {
            case .loading:
                self?.showWhisper(message: L10n.signing_in)
                self?.loginButton.isEnabled = false
            case .content:
                self?.hideWhisper()
                self?.loginButton.isEnabled = true
                self?.flowDelegate?.dismiss()
            case .error(let error):
                self?.showWhisperWithError(error)
                self?.loginButton.isEnabled = true
            }
        }).disposed(by: disposeBag)
        
        registerButton.rx.tap.bind { [weak self] in
            self?.flowDelegate?.showRegistration()
        }.disposed(by: disposeBag)
    }
    
    override func setupUI() {
        super.setupUI()
        
        emailTextField.textField.keyboardType = .emailAddress
        passwordTextField.textField.keyboardType = .asciiCapable
    }
    
    // MARK: Additional methods
    
}
