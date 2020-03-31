//
//  Screen.swift
//  DevStackUITests
//
//  Created by Matee on 01/01/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import XCTest

class BaseScreen {
    // MARK: - Public Properties

    let app: XCUIApplication!

    // MARK: - Init

    init(inApp app: XCUIApplication) {
        self.app = app
    }

    // MARK: - Public Methods

    func waitForElement(element: XCUIElement) {
        _ = element.waitForExistence(timeout: 10)
    }

    func elementPresent(_ element: XCUIElement) -> Bool {
        return element.exists
    }

    func pressElement(element: XCUIElement) {
        element.press(forDuration: 1.5)
    }
}
