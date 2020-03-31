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
    private let baseButton = PrimaryButton(frame: CGRect(origin: .zero, size: CGSize(width: 300, height: 58)))

    // MARK: - Public Methods
    override func setUp() {
        super.setUp()
        record = false
    }

    func testDefaultAppearance() {
        XCTAssertEqual(baseButton.backgroundColor?.cgColor, AppTheme.Colors.primaryButtonBackground.cgColor)
        XCTAssertEqual(baseButton.titleColor(for: .normal)?.cgColor, UIColor.white.cgColor)
        XCTAssertEqual(baseButton.layer.cornerRadius, 5)
        baseButton.setTitle("BUTTON", for: .normal)
        assertSnapshot(matching: baseButton, as: .image)
    }
    
    

}
