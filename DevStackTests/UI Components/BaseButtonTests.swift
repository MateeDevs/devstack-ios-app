//
//  BaseButtonTests.swift
//  DevStackTests
//
//  Created by Matee on 29/12/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import SnapshotTesting
@testable import DevStack
import XCTest

class BaseButtonTests: XCTestCase {
    
    // MARK: - Private Properties
    
    private let baseButton = BaseButton(frame: CGRect(origin: .zero, size: CGSize(width: 300, height: 58)))
    private let styledButton = BaseButton(type: .contactAdd)

    // MARK: - Public Methods
    
    override func setUp() {
//        record = true
    }

    func testDefaultAppearance() {
        XCTAssertEqual(baseButton.backgroundColor?.cgColor, ColorTheme.mainTheme.cgColor)
        XCTAssertEqual(baseButton.titleColor(for: .normal)?.cgColor, UIColor.white.cgColor)
        XCTAssertEqual(baseButton.layer.cornerRadius, 5)
        baseButton.setTitle("BUTTON", for: .normal)
        assertSnapshot(matching: baseButton, as: .image)
    }

}
