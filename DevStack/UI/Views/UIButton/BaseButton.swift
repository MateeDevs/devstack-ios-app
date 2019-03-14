//
//  BaseButton.swift
//  DevStack
//
//  Created by Petr Chmelar on 19/07/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

class BaseButton: EnhancedButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cornerRadius = 5.0
        backgroundColor = ColorTheme.mainColor
        setTitleColor(UIColor.white, for: .normal)
        
        if let label = titleLabel {
            label.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
            label.numberOfLines = 1
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 0.75
        }
        
        contentEdgeInsets.top = 16
        contentEdgeInsets.left = 16
        contentEdgeInsets.bottom = 16
        contentEdgeInsets.right = 16
    }
    
}