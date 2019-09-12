//
//  LocalizedTextField.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 22/06/2017.
//  Copyright © 2017 Matee. All rights reserved.
//

import UIKit

open class LocalizedTextField: UITextField {
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        if let placeholder = placeholder {
            self.placeholder = NSLocalizedString(placeholder, comment: "")
        }
    }
    
}
