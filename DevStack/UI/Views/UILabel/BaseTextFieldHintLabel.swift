//
//  BaseTextFieldHintLabel.swift
//  DevStack
//
//  Created by Petr Chmelar on 19/07/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

class BaseTextFieldHintLabel: LocalizedLabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textColor = .gray
        font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
    }
    
}
