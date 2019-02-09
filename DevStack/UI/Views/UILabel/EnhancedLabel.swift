//
//  EnhancedLabel.swift
//  DevStack
//
//  Created by Petr Chmelar on 19/07/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

@IBDesignable class EnhancedLabel: LocalizedLabel {
    
    @IBInspectable var charSpace: Double = 1.0 {
        didSet {
            reloadAttributedTitle()
        }
    }
    
    @IBInspectable var lineSpace: Double = 1.0 {
        didSet {
            reloadAttributedTitle()
        }
    }
    
    @IBInspectable var lineHeight: Double = 1.0 {
        didSet {
            reloadAttributedTitle()
        }
    }
    
    private func reloadAttributedTitle() {
        if var text = text {
            text = NSLocalizedString(text, comment: "")
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = CGFloat(lineSpace)
            paragraphStyle.lineHeightMultiple = CGFloat(lineHeight)
            
            let attributes: [NSAttributedString.Key : Any] = [
                NSAttributedString.Key.kern: charSpace,
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ]
            
            let attributedString = NSMutableAttributedString(string: text, attributes: attributes)
            attributedText = attributedString
        }
    }
    
}
