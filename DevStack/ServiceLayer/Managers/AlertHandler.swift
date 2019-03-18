//
//  AlertHandler.swift
//  DevStack
//
//  Created by Petr Chmelar on 25/07/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

public struct AlertHandler {
    
    ///
    /// Present UIAlertController on current top ViewController.
    ///
    /// - parameter title: Title for UIAlertController.
    /// - parameter message: Message for UIAlertController.
    /// - parameter primaryAction: Primary action for UIAlertController. If not specified, default action will be added.
    /// - parameter secondaryAction: Secondary action for UIAlertController.
    ///
    public static func showAlert(title: String = L10n.dialogErrorTitle, message: String? = nil,
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
    public static func showAlertWithError(_ error: Error, title: String = L10n.dialogErrorTitle,
                                          primaryAction: UIAlertAction? = nil, secondaryAction: UIAlertAction? = nil) {
        showAlert(title: title, message: error.localizedDescription, primaryAction: primaryAction, secondaryAction: secondaryAction)
    }
    
}
