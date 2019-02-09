//
//  AlertHandler.swift
//  Shipvio3
//
//  Created by Petr Chmelar on 25/07/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

// FIXME: Find or implement alternative for Whisper

import UIKit
//import Whisper

enum AlertMessageType: Int {
    case info = 0
    case success = 1
    case error = 2
}

class AlertHandler {
    
    static func showAlert(title: String, message: String? = nil,
                          defaultActionText: String, defaultActionStyle: UIAlertAction.Style = .default, defaultActionHandler: ((UIAlertAction) -> Void)? = nil,
                          cancelActionText: String? = nil, cancelActionStyle: UIAlertAction.Style = .cancel, cancelActionHandler: ((UIAlertAction) -> Void)? = nil) {
        if let vc = UIApplication.topViewController() {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: defaultActionText, style: defaultActionStyle, handler: defaultActionHandler)
            alert.addAction(defaultAction)
            
            if (cancelActionText != nil) {
                let cancelAction = UIAlertAction(title: cancelActionText, style: cancelActionStyle, handler: cancelActionHandler)
                alert.addAction(cancelAction)
            }
            
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
    static func showAlertWithError(_ error: ServiceError, title: String = L10n.dialogErrorTitle,
                                   messages: [Int : String] = [:], defaultMessage: String = L10n.unknownError,
                                   defaultActionText: String = L10n.dialogErrorCloseText, defaultActionStyle: UIAlertAction.Style = .default,
                                   defaultActionHandler: ((UIAlertAction) -> Void)? = nil) {
        if let message = messages[error.statusCode] {
            showAlert(title: title, message: message, defaultActionText: defaultActionText, defaultActionStyle: defaultActionStyle, defaultActionHandler: defaultActionHandler)
        } else if error.statusCode == StatusCode.validationError {
            showAlert(title: title, message: error.message, defaultActionText: defaultActionText, defaultActionStyle: defaultActionStyle, defaultActionHandler: defaultActionHandler)
        } else {
            showAlert(title: title, message: defaultMessage, defaultActionText: defaultActionText, defaultActionStyle: defaultActionStyle, defaultActionHandler: defaultActionHandler)
        }
    }
    
    static func showWhisper(message: String, type: AlertMessageType = AlertMessageType.info, shouldHide: Bool = false) {
//
//        // set a color based on the message type
//        let bgColor: UIColor
//        switch type {
//        case .info:
//            bgColor = Asset.Colors.alertInfo.color
//        case .success:
//            bgColor = Asset.Colors.alertSuccess.color
//        case .error:
//            bgColor = Asset.Colors.alertError.color
//        }
//
//        if let navVc = UIApplication.topViewController()?.navigationController, !navVc.navigationBar.isHidden {
//            let msg = Message(title: message, textColor: UIColor.white, backgroundColor: bgColor)
//            if shouldHide {
//                Whisper.show(whisper: msg, to: navVc, action: .show)
//            } else {
//                Whisper.show(whisper: msg, to: navVc, action: .present)
//            }
//        } else {
//            let msg = Murmur(title: message, backgroundColor: bgColor, titleColor: UIColor.white)
//            if shouldHide {
//                Whisper.show(whistle: msg, action: .show(2.5))
//            } else {
//                Whisper.show(whistle: msg, action: .present)
//            }
//        }
    }
    
    static func showWhisperWithError(_ error: ServiceError, messages: [Int : String] = [:], defaultMessage: String = L10n.unknownError) {
//        if let message = messages[error.statusCode] {
//            showWhisper(message: message, type: .error, shouldHide: true)
//        } else if error.statusCode == StatusCode.validationError {
//            showWhisper(message: error.message, type: .error, shouldHide: true)
//        } else {
//            showWhisper(message: defaultMessage, type: .error, shouldHide: true)
//        }
    }
    
    static func hideWhisper() {
//        if let navVc = UIApplication.topViewController()?.navigationController, !navVc.navigationBar.isHidden {
//            Whisper.hide(whisperFrom: navVc)
//        }
//        Whisper.hide(whistleAfter: 0)
    }
    
}
