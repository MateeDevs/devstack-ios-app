//
//  TestConfig.swift
//  DevStackUITests
//
//  Created by Matee on 01/01/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import XCTest

class TestConfig: XCTestCase {

    // MARK: - Private Properties

    private var monitor: NSObjectProtocol?

    // MARK: - View

    override func tearDown() {
        super.tearDown()

        let screenshot = XCUIScreen.main.screenshot()
        let fullScreenshotAttachment = XCTAttachment(screenshot: screenshot)
        fullScreenshotAttachment.lifetime = .deleteOnSuccess
        add(fullScreenshotAttachment)

        if let monitor = monitor {
            removeUIInterruptionMonitor(monitor)
            self.monitor = nil
        }
    }

    // MARK: - Public Methods

    func assertElement(_ element: XCUIElement, exist: Bool, file: StaticString = #file, line: UInt = #line) {
        let elementPresent = element.waitForExistence(timeout: 10)
        if exist {
            XCTAssertTrue(elementPresent, "Element not present", file: file, line: line)
        } else {
            XCTAssertFalse(elementPresent, "Element present", file: file, line: line)
        }
    }

    func assertElement(_ element: XCUIElement, enabled: Bool) {
        let elementPresent = element.waitForExistence(timeout: 10)
        if elementPresent {
            XCTAssertEqual(enabled, element.isEnabled)
        } else {
            XCTFail("Element not present")
        }
    }

    func launch(app: XCUIApplication, launchArguments: [String] = []) {
        app.launchArguments = ["ui-test"]
        app.launchArguments += launchArguments
        app.launch()
        // the following will be active during the entire test run
        // this means any alert will be affected
        monitor = addUIInterruptionMonitor(withDescription: "System Dialog") { alert -> Bool in
            if alert.buttons["Allow"].exists {
                alert.buttons["Allow"].tap()
                app.tap()
                return true
            } else if alert.buttons["Allow While Using App"].exists {
                alert.buttons["Allow While Using App"].tap()
                app.tap()
                return true
            }
            sleep(10)
            return false
        }
        app.tap()
    }
}
