//
//  LoginScreen.swift
//  DevStackUITests
//
//  Created by Matee on 01/01/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import XCTest

class LoginScreen: BaseScreen {

    // MARK: - Private Properties
    
    private let email = "petr.chmelar@matee.cz"
    private let password = "11111111"
    private(set) lazy var emailTextField: XCUIElement = app.textFields["emailTextField"]
    private(set) lazy var passwordTextField: XCUIElement = app.secureTextFields["passwordTextField"]
    private(set) lazy var loginButton: XCUIElement = app.buttons["loginButton"]
    private(set) lazy var registerButton: XCUIElement = app.buttons["registerButton"]
    
    // MARK: - Private Methods
    
    func tapOnLoginButton() {
        waitForElement(element: loginButton)
        loginButton.tap()
    }
    
    func tapOnRegisterButton() {
        waitForElement(element: registerButton)
        registerButton.tap()
    }
    
    func enterEmail() {
        waitForElement(element: emailTextField)
        emailTextField.tap()
        emailTextField.typeText(email)
    }
    
    func enterPassword() {
        waitForElement(element: passwordTextField)
        passwordTextField.doubleTap()
        passwordTextField.typeText(password)
    }
}
