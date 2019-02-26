//
//  LocalizedButton.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 21/06/2017.
//  Copyright © 2017 Qest. All rights reserved.
//

import UIKit

open class LocalizedButton: UIButton {
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        for state in [UIControl.State.normal, UIControl.State.highlighted, UIControl.State.selected, UIControl.State.disabled] {
            if let title = title(for: state) {
                setTitle(NSLocalizedString(title, comment: ""), for: state)
            }
        }
        
        // Change alignment for right to left languages
        if contentHorizontalAlignment == .right && UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .rightToLeft {
            contentHorizontalAlignment = .left
        }
    }
    
}
