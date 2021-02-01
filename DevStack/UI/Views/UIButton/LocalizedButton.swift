//
//  LocalizedButton.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 21/06/2017.
//  Copyright © 2017 Matee. All rights reserved.
//

import UIKit

open class LocalizedButton: StateButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
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
