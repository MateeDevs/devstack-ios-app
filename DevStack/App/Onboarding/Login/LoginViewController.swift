//
//  LoginViewController.swift
//  DevStack
//
//  Created by Petr Chmelar on 04/02/2019.
//  Copyright © 2019 Qest. All rights reserved.
//

import UIKit
import RxSwift

protocol LoginFlowDelegate: class {
    func popToMain()
}

final class LoginViewController: InputViewController {
    
    // MARK: FlowDelegate
    weak var flowDelegate: LoginFlowDelegate?
    
    // MARK: ViewModels
    private var viewModel: LoginViewModel!
    
    // MARK: UI components
    @IBOutlet private weak var emailTextFieldView: UIView!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextFieldView: UIView!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: BaseButton!
    
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
        emailTextField.text = "petr.chmelar@qest.cz"
        passwordTextField.text = "11111111"
        #elseif BETA
        emailTextField.text = "petr.chmelar@qest.cz"
        passwordTextField.text = "11111111"
        #endif
    }
    
    // MARK: Default methods
    override func setupViewModel() {
        super.setupViewModel()
        
        let input = LoginViewModel.Input(email: emailTextField.rx.text.orEmpty.asDriver(),
                                         password: passwordTextField.rx.text.orEmpty.asDriver(),
                                         loginButtonTaps: loginButton.rx.tap.asSignal())
        let output = viewModel?.transform(input: input)
        
        output?.values.drive(onNext: { (text) in
            print(text)
        }).disposed(by: disposeBag)
        
        output?.loginEvent.drive(onNext: { [weak self] event in
            if event.isLoading {
                self?.view.startActivityIndicator()
            } else if let error = event.error {
                self?.view.stopActivityIndicator()
                AlertHandler.showAlertWithError(
                    error,
                    messages: [401:L10n.invalidCredentials],
                    defaultMessage: L10n.signingFailed
                )
            } else {
                self?.view.stopActivityIndicator()
                self?.flowDelegate?.popToMain()
            }
        }).disposed(by: disposeBag)
        
        output?.loginButtonEnabled.drive(onNext: { [weak self] (enabled) in
            self?.loginButton.isEnabled = enabled
        }).disposed(by: disposeBag)
    }
    
    override func setupViewAppearance() {
        super.setupViewAppearance()
        
        emailTextFieldView.layer.borderWidth = 2.0
        emailTextFieldView.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextFieldView.layer.borderWidth = 2.0
        passwordTextFieldView.layer.borderColor = UIColor.lightGray.cgColor
        
        emailTextField.textContentType = UITextContentType(rawValue: "")
        passwordTextField.textContentType = UITextContentType(rawValue: "")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    // MARK: Custom methods
    
}
