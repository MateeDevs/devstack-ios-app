//
//  SecondaryButton.swift
//  DevStack
//
//  Created by Petr Chmelar on 04/01/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import UIKit

class SecondaryButton: LocalizedButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        tintColor = AppTheme.Colors.secondaryButtonTitle
    }
    
}
