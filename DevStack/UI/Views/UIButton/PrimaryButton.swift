//
//  PrimaryButton.swift
//  DevStack
//
//  Created by Petr Chmelar on 19/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

class PrimaryButton: EnhancedButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cornerRadius = 5.0
        backgroundColor = AppTheme.Colors.primaryButtonBackground
        setTitleColor(AppTheme.Colors.primaryButtonTitle, for: .normal)
        
        if let label = titleLabel {
            label.font = AppTheme.Fonts.primaryButton
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
