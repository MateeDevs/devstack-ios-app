//
//  GradientView.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 22/10/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

@IBDesignable open class GradientView: UIView {
    
    @IBInspectable public var color1: UIColor = .black
    @IBInspectable public var color2: UIColor = .white
    
    @IBInspectable public var location1: CGFloat = 0.0
    @IBInspectable public var location2: CGFloat = 1.0
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        applyGradientLayer()
    }

    func applyGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        gradientLayer.locations = [location1, location2] as [NSNumber]
        layer.addSublayer(gradientLayer)
    }

}
