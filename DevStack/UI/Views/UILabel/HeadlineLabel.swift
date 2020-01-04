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
        
        textColor = ColorTheme.headlineLabel
        font = UIFont.systemFont(ofSize: 28.0, weight: .medium)
        numberOfLines = 1
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
    }
    
}
