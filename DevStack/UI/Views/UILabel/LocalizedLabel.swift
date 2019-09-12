//
//  LocalizedLabel.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 21/06/2017.
//  Copyright © 2017 Matee. All rights reserved.
//

import UIKit

@IBDesignable open class LocalizedLabel: UILabel {
    
    @IBInspectable public var requiredSymbol: String?
    @IBInspectable public var uppercased: Bool = false

    override open func awakeFromNib() {
        super.awakeFromNib()
        
        if let text = text {
            if uppercased {
                self.text = NSLocalizedString(text, comment: "").uppercased()
            } else {
                self.text = NSLocalizedString(text, comment: "")
            }
            
            if let symbol = requiredSymbol {
                self.text = text + " " + symbol
            }
        }
        
        // Change alignment for right to left languages
        if textAlignment == .right && UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .rightToLeft {
            textAlignment = .left
        }
    }
    
}
