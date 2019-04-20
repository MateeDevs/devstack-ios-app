//
//  BaseViewController+Alerts.swift
//  DevStack
//
//  Created by Petr Chmelar on 25/07/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

extension BaseViewController {
    
    ///
    /// Present UIAlertController on current top ViewController.
    ///
    /// - parameter title: Title for UIAlertController.
    /// - parameter message: Message for UIAlertController.
    /// - parameter primaryAction: Primary action for UIAlertController. If not specified, default action will be added.
    /// - parameter secondaryAction: Secondary action for UIAlertController.
    ///
    public func showAlert(title: String, message: String? = nil,
                                 primaryAction: UIAlertAction? = nil, secondaryAction: UIAlertAction? = nil) {
        guard let vc = UIApplication.topViewController() else { return }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let primaryAction = primaryAction {
            alert.addAction(primaryAction)
        } else {
            alert.addAction(UIAlertAction(title: L10n.dialogErrorCloseText, style: .default, handler: nil))
        }
        
        if let secondaryAction = secondaryAction {
            alert.addAction(secondaryAction)
        }
        
        vc.present(alert, animated: true, completion: nil)
    }
    
    ///
    /// Present UIAlertController on current top ViewController. Message is based on a given error.
    ///
    /// - parameter error: Error for which the alert will be presented.
    /// - parameter title: Title for UIAlertController.
    /// - parameter primaryAction: Primary action for UIAlertController. If not specified, default action will be added.
    /// - parameter secondaryAction: Secondary action for UIAlertController.
    ///
    public func showAlertWithError(_ error: Error, title: String = L10n.dialogErrorTitle,
                                          primaryAction: UIAlertAction? = nil, secondaryAction: UIAlertAction? = nil) {
        showAlert(title: title, message: error.localizedDescription, primaryAction: primaryAction, secondaryAction: secondaryAction)
    }
    
    ///
    /// Present WhisperView on current top ViewController.
    ///
    /// - parameter message: Message for WhisperView.
    /// - parameter style: Specifies style for WhisperView.
    /// - parameter hideAfter: Automatically hide WhisperView after a given interval (0 for permanent whisper).
    ///
    public func showWhisper(message: String, style: WhisperStyle = .info, hideAfter: TimeInterval = 0.0) {
        guard let vc = UIApplication.topViewController() else { return }
        
        let whisper = WhisperView(frame: CGRect(x: 0, y: -vc.view.safeAreaInsets.top - 25,
                                                width: vc.view.bounds.width, height: vc.view.safeAreaInsets.top + 25))
        whisper.message = message
        whisper.backgroundColor = style.color
        
        hideWhisper()
        vc.view.addSubview(whisper)
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
            whisper.frame.origin.y = 0
        }, completion: nil)
        
        if hideAfter > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + hideAfter) { [weak self] in
                self?.hideWhisper()
            }
        }
    }
    
    ///
    /// Present WhisperView on current top ViewController. Message is based on a given error.
    ///
    /// - parameter error: Error for which the alert will be presented.
    /// - parameter hideAfter: Automatically hide WhisperView after a given interval (0 for permanent whisper).
    ///
    public func showWhisperWithError(_ error: Error, hideAfter: TimeInterval = 2.5) {
        showWhisper(message: error.localizedDescription, style: .error, hideAfter: hideAfter)
    }
    
    /// Hide and remove WhisperView from current top ViewController.
    public func hideWhisper() {
        guard let vc = UIApplication.topViewController() else { return }
        
        for view in vc.view.subviews {
            if view.isKind(of: WhisperView.self) {
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
                    view.frame.origin.y = -vc.view.safeAreaInsets.top - 30
                }, completion: { finished in
                    view.removeFromSuperview()
                })
            }
        }
    }
    
}
