//
//  LoginViewControllerTests.swift
//  DevStackTests
//
//  Created by Matee on 30/12/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

@testable import DevStack
import XCTest

class LoginViewControllerTests: XCTestCase {
    
    // MARK: - Private Properties
    
    private var loginViewController: LoginViewController!
    private var viewModel: LoginViewModel!
    private var dependencies: LoginServiceMock!

    // MARK: - Public Methods
    
    override func setUp() {
        dependencies = LoginServiceMock()
        viewModel = LoginViewModel(dependencies: dependencies)
        loginViewController = LoginViewController.instantiate(viewModel: viewModel)
        
        loginViewController.beginAppearanceTransition(true, animated: false)
        loginViewController.endAppearanceTransition()
    }

    override func tearDown() {
        loginViewController = nil
        viewModel = nil
        dependencies = nil
        
        super.tearDown()
    }

    func testValidInputAppearance() {
        loginViewController.emailTextField.text = "petr.chmelar@matee.cz"
        loginViewController.emailTextField.sendActions(for: .editingChanged)
        loginViewController.passwordTextField.text = "11111111"
        loginViewController.passwordTextField.sendActions(for: .editingChanged)
        
        loginViewController.loginButton.sendActions(for: .touchUpInside)
        let whisperView = loginViewController.view?.subviews.filter({ $0 is WhisperView}).first ?? UIView()

        XCTAssertTrue(loginViewController.view?.subviews.contains(whisperView) ?? false)
        XCTAssertEqual((whisperView as? WhisperView)?.messageLabel.text, L10n.signing_in)
    }

    func testInvalidInputAppearance() {
        loginViewController.emailTextField.text = "petr.chmelar@matee.cz"
        loginViewController.emailTextField.sendActions(for: .editingChanged)
        
        loginViewController.loginButton.sendActions(for: .touchUpInside)
        let whisperView = loginViewController.view?.subviews.filter({ $0 is WhisperView}).first ?? UIView()

        XCTAssertTrue(loginViewController.view?.subviews.contains(whisperView) ?? false)
        XCTAssertEqual((whisperView as? WhisperView)?.backgroundColor, Asset.Colors.alertError.color)
    }


}
