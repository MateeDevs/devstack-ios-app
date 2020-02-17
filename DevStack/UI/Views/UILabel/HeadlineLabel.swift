//
//  HeadlineLabel.swift
//  DevStack
//
//  Created by Petr Chmelar on 19/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

class HeadlineLabel: LocalizedLabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        textColor = AppTheme.Colors.headlineLabel
        font = AppTheme.Fonts.headlineLabel
        numberOfLines = 1
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
    }
    
}
