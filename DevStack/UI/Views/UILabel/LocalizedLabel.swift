//
//  LocalizedLabel.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 21/06/2017.
//  Copyright © 2017 Qest. All rights reserved.
//

import UIKit

@IBDesignable class LocalizedLabel: UILabel {
    @IBInspectable var requiredSymbol : String?
    @IBInspectable var uppercased: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        if let text = text {
            if uppercased {
                self.text = NSLocalizedString(text, comment: "").uppercased()
            } else {
                self.text = NSLocalizedString(text, comment: "")
            }
            
            if let symbol = requiredSymbol, let text = self.text {
                self.text = text + " " + symbol
            }
        }
        
        // Change alignment for right to left languages
        if textAlignment == .right && UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .rightToLeft {
            textAlignment = .left
        }
    }
    
}
