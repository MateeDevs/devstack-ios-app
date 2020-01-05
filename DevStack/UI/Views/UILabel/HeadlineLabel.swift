//
//  HeadlineLabel.swift
//  DevStack
//
//  Created by Petr Chmelar on 19/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

class HeadlineLabel: LocalizedLabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textColor = AppTheme.Colors.headlineLabel
        font = AppTheme.Fonts.headlineLabel
        numberOfLines = 1
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
    }
    
}
