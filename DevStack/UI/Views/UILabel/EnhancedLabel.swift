//
//  EnhancedLabel.swift
//  DevStack
//
//  Created by Petr Chmelar on 19/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

@IBDesignable open class EnhancedLabel: LocalizedLabel {
    
    @IBInspectable public var charSpace: Double = 1.0 {
        didSet {
            reloadAttributedTitle()
        }
    }
    
    @IBInspectable public var lineSpace: Double = 1.0 {
        didSet {
            reloadAttributedTitle()
        }
    }
    
    @IBInspectable public var lineHeight: Double = 1.0 {
        didSet {
            reloadAttributedTitle()
        }
    }
    
    private func reloadAttributedTitle() {
        guard let text = text else { return }
            
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = CGFloat(lineSpace)
        paragraphStyle.lineHeightMultiple = CGFloat(lineHeight)
            
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.kern: charSpace,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]
            
        let attributedString = NSMutableAttributedString(string: text, attributes: attributes)
        attributedText = attributedString
    }
    
}
