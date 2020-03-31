//
//  LoginUITests.swift
//  DevStackUITests
//
//  Created by Matee on 01/01/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import XCTest

class LoginUITests: TestConfig {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }

    func testLogin() {
        let app = XCUIApplication()
        let login = LoginScreen(inApp: app)
        launch(app: app)

        assertElement(login.emailTextField, exist: true)
        login.enterEmail()

        assertElement(login.passwordTextField, exist: true)
        login.enterPassword()
        
        assertElement(login.loginButton, exist: true)
        login.tapOnLoginButton()
        
        XCTAssertTrue(app.staticTexts["Signing in…"].exists)
        
        app.terminate()
    }
}
