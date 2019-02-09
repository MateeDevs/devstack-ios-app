//
//  LocalizedTextField.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 22/06/2017.
//  Copyright © 2017 Qest. All rights reserved.
//

import UIKit

class LocalizedTextField: UITextField {
    
    var pasteActionEnabled : Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let placeholder = self.placeholder {
            self.placeholder = NSLocalizedString(placeholder, comment: "")
        }
    }
    
    func validateIntegerValue(value: String?, defaultValue: String? = nil) {
        guard let text = value else {
            return
        }
        if let intValue = Int(text) {
            self.text = "\(intValue)"
        } else if let defValue = defaultValue {
            self.text = defValue
        }
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return pasteActionEnabled
        }
        return super.canPerformAction(action, withSender: sender)
    }
    
}
