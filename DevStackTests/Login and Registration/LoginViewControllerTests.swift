//
//  LoginViewControllerTests.swift
//  DevStackTests
//
//  Created by Matee on 30/12/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

@testable import A_DevStack
import XCTest

class LoginViewControllerTests: XCTestCase {
    
    // MARK: - Private Properties
    
    private var loginViewController: LoginViewController!
    private var viewModel: LoginViewModel!
    private var dependencies: AppDependency!

    // MARK: - Public Methods
    
    override func setUp() {
        super.setUp()
        dependencies = AppDependency()
        viewModel = LoginViewModel(dependencies: dependencies)
        loginViewController = LoginViewController.instantiate(viewModel: viewModel)
        
        loginViewController.beginAppearanceTransition(true, animated: false)
        loginViewController.endAppearanceTransition()
    }

    override func tearDown() {
        super.tearDown()
        loginViewController = nil
        viewModel = nil
        dependencies = nil
    }

    func testValidInputAppearance() {
        loginViewController.emailTextField.textField.text = "petr.chmelar@matee.cz"
        loginViewController.emailTextField.textField.sendActions(for: .editingChanged)
        loginViewController.passwordTextField.textField.text = "11111111"
        loginViewController.passwordTextField.textField.sendActions(for: .editingChanged)
        
        loginViewController.loginButton.sendActions(for: .touchUpInside)

        if let whisperView = loginViewController.view.subviews.filter({ $0 is WhisperView }).first as? WhisperView {
            XCTAssertEqual(whisperView.messageLabel.text, L10n.signing_in)
        } else {
            XCTFail()
        }
    }

    func testInvalidInputAppearance() {
        loginViewController.emailTextField.textField.text = "petr.chmelar@matee.cz"
        loginViewController.emailTextField.textField.sendActions(for: .editingChanged)
        
        loginViewController.loginButton.sendActions(for: .touchUpInside)

        if let whisperView = loginViewController.view.subviews.filter({ $0 is WhisperView }).first as? WhisperView {
            XCTAssertEqual(whisperView.messageLabel.backgroundColor, AppTheme.Colors.alertBackgroundSuccess)
        } else {
            XCTFail()
        }
    }
}
