//
//  LocalizedImageView.swift
//  Shipvio3
//
//  Created by Petr Chmelar on 24/10/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

class LocalizedImageView: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        image = image?.imageFlippedForRightToLeftLayoutDirection()
    }
    
}
