//
//  LocalizedImageView.swift
//  DevStack
//
//  Created by Petr Chmelar on 24/10/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

open class LocalizedImageView: UIImageView {
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        image = image?.imageFlippedForRightToLeftLayoutDirection()
    }
    
}
