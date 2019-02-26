//
//  LocalizedTextView.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 22/06/2017.
//  Copyright © 2017 Qest. All rights reserved.
//

import UIKit

@IBDesignable open class LocalizedTextView: UITextView {
    
    private(set) var placeholder: String?
    private(set) var defaultColor: UIColor?
    @IBInspectable public var placeholderColor: UIColor = .black
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        placeholder = NSLocalizedString(text, comment: "")
        text = placeholder
        
        defaultColor = textColor
        textColor = placeholderColor
    }
    
}
