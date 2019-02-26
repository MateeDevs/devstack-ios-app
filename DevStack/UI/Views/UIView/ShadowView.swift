//
//  ShadowView.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 27/08/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

open class ShadowView: UIView {
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 2
    }

}
