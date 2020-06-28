//
//  BaseViewController+Alerts.swift
//  DevStack
//
//  Created by Petr Chmelar on 25/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

public enum WhisperAction: Equatable {
    case showMessage(_ message: String, hideAfter: TimeInterval = 0.0)
    case showError(_ message: String, hideAfter: TimeInterval = 2.5)
    case hide

    public static func == (lhs: WhisperAction, rhs: WhisperAction) -> Bool {
        switch (lhs, rhs) {
        case let (.showMessage(lhsMessage, lhsHide), .showMessage(rhsMessage, rhsHide)):
            return lhsMessage == rhsMessage && lhsHide == rhsHide
        case let (.showError(lhsError, lhsHide), .showError(rhsError, rhsHide)):
            return lhsError == rhsError && lhsHide == rhsHide
        case (.hide, .hide):
            return true
        default:
            return false
        }
    }
}

public extension BaseViewController {
    
    ///
    /// Present UIAlertController on current top ViewController.
    ///
    /// - parameter title: Title for UIAlertController.
    /// - parameter message: Message for UIAlertController.
    /// - parameter primaryAction: Primary action for UIAlertController. If not specified, default action will be added.
    /// - parameter secondaryAction: Secondary action for UIAlertController.
    ///
    func showAlert(
        title: String,
        message: String? = nil,
        primaryAction: UIAlertAction? = nil,
        secondaryAction: UIAlertAction? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let primaryAction = primaryAction {
            alert.addAction(primaryAction)
        } else {
			alert.addAction(UIAlertAction(title: L10n.dialog_error_close_text, style: .default, handler: nil))
        }
        
        if let secondaryAction = secondaryAction {
            alert.addAction(secondaryAction)
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    ///
    /// Present UIAlertController on current top ViewController. Message is based on a given error.
    ///
    /// - parameter error: Error for which the alert will be presented.
    /// - parameter title: Title for UIAlertController.
    /// - parameter primaryAction: Primary action for UIAlertController. If not specified, default action will be added.
    /// - parameter secondaryAction: Secondary action for UIAlertController.
    ///
	func showAlertWithError(
        _ error: Error,
        title: String = L10n.dialog_error_title,
        primaryAction: UIAlertAction? = nil,
        secondaryAction: UIAlertAction? = nil
    ) {
        showAlert(title: title, message: error.localizedDescription, primaryAction: primaryAction, secondaryAction: secondaryAction)
    }
    
    ///
    /// Handle WhisperView on current top ViewController based on a given WhisperAction.
    ///
    /// - parameter action: Action for WhisperView.
    ///
    func handleWhisper(_ action: WhisperAction) {
        switch action {
        case let .showMessage(message, hideAfter):
            showWhisper(message, hideAfter: hideAfter)
        case let .showError(message, hideAfter):
            showWhisper(message, style: .error, hideAfter: hideAfter)
        case .hide:
            hideWhisper()
        }
    }
    
    ///
    /// Present WhisperView on current top ViewController.
    ///
    /// - parameter message: Message for WhisperView.
    /// - parameter style: Specifies style for WhisperView.
    /// - parameter hideAfter: Automatically hide WhisperView after a given interval (0 for permanent whisper).
    ///
    func showWhisper(
        _ message: String,
        style: WhisperStyle = .info,
        hideAfter: TimeInterval = 0.0
    ) {
        let whisper = WhisperView(frame: CGRect(
            x: 0,
            y: -view.safeAreaInsets.top - 25,
            width: view.bounds.width,
            height: view.safeAreaInsets.top + 25
        ))
        whisper.message = message
        whisper.backgroundColor = style.color
        
        hideWhisper()
        view.addSubview(whisper)
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .curveLinear,
            animations: { whisper.frame.origin.y = 0 },
            completion: nil
        )
        
        if hideAfter > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + hideAfter) { [weak self] in
                self?.hideWhisper()
            }
        }
    }
    
    /// Hide and remove WhisperView from current top ViewController.
    func hideWhisper() {
        for view in view.subviews where view.isKind(of: WhisperView.self) {
            UIView.animate(
                withDuration: 0.2,
                delay: 0,
                options: .curveLinear,
                animations: { view.frame.origin.y = -view.safeAreaInsets.top - 30 },
                completion: { _ in view.removeFromSuperview() }
            )
        }
    }
    
}
