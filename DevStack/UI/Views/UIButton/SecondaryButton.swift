//
//  SecondaryButton.swift
//  DevStack
//
//  Created by Petr Chmelar on 04/01/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import UIKit

class SecondaryButton: LocalizedButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tintColor = AppTheme.Colors.secondaryButtonTitle
    }
    
}
