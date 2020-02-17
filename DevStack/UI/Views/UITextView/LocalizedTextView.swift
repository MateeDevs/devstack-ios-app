//
//  LocalizedTextView.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 22/06/2017.
//  Copyright © 2017 Matee. All rights reserved.
//

import UIKit

@IBDesignable open class LocalizedTextView: UITextView {
    
    private(set) var placeholder: String?
    private(set) var defaultColor: UIColor?
    @IBInspectable public var placeholderColor: UIColor = AppTheme.Colors.placeholder
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        placeholder = NSLocalizedString(text, comment: "")
        text = placeholder
        
        defaultColor = textColor
        textColor = placeholderColor
    }
    
}
