//
//  LocalizedLabel.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 21/06/2017.
//  Copyright © 2017 Matee. All rights reserved.
//

import UIKit

@IBDesignable open class LocalizedLabel: UILabel {

    // MARK: UI components

    // MARK: Stored properties
    @IBInspectable public var requiredSymbol: String?
    @IBInspectable public var uppercased: Bool = false

    // MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: Default methods
    private func setup() {
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

    // MARK: Additional methods
    
}
