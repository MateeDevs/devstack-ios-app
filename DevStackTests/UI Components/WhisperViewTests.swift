//
//  WhisperViewTests.swift
//  DevStackTests
//
//  Created by Matee on 29/12/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import SnapshotTesting
@testable import DevStack
import XCTest

class WhisperViewTests: XCTestCase {
    
    // MARK: - Private Properties
    
    private let whisperView = WhisperView(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 70)))

    // MARK: - Public Methods
    
    override func setUp() {
//        record = true
    }

    func testInfoAppearance() {
        whisperView.backgroundColor = WhisperStyle.info.color
        XCTAssertEqual(whisperView.messageLabel.font, .systemFont(ofSize: 13.0, weight: .medium))
        XCTAssertEqual(whisperView.messageLabel.textColor.cgColor, UIColor.white.cgColor)
        XCTAssertEqual(whisperView.messageLabel.textAlignment, NSTextAlignment.center)
        XCTAssertEqual(whisperView.backgroundColor, Asset.Colors.alertInfo.color)
        whisperView.messageLabel.text = "Default test message"
        assertSnapshot(matching: whisperView, as: .image)
    }
    
    func testSuccessAppearance() {
        whisperView.backgroundColor = WhisperStyle.success.color
        XCTAssertEqual(whisperView.messageLabel.font, .systemFont(ofSize: 13.0, weight: .medium))
        XCTAssertEqual(whisperView.messageLabel.textColor.cgColor, UIColor.white.cgColor)
        XCTAssertEqual(whisperView.messageLabel.textAlignment, NSTextAlignment.center)
        XCTAssertEqual(whisperView.backgroundColor, Asset.Colors.alertSuccess.color)
        whisperView.messageLabel.text = "Default success message"
        assertSnapshot(matching: whisperView, as: .image)
    }
    
    func testErrorAppearance() {
        whisperView.backgroundColor = WhisperStyle.error.color
        XCTAssertEqual(whisperView.messageLabel.font, .systemFont(ofSize: 13.0, weight: .medium))
        XCTAssertEqual(whisperView.messageLabel.textColor.cgColor, UIColor.white.cgColor)
        XCTAssertEqual(whisperView.messageLabel.textAlignment, NSTextAlignment.center)
        XCTAssertEqual(whisperView.backgroundColor, Asset.Colors.alertError.color)
        whisperView.messageLabel.text = "Default error message"
        assertSnapshot(matching: whisperView, as: .image)
    }

}
