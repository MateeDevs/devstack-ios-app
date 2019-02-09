//
//  GradientView.swift
//  Shipvio3
//
//  Created by Viktor Kaderabek on 22/10/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    @IBInspectable var color1: UIColor = UIColor.red
    @IBInspectable var color2: UIColor = UIColor.yellow
    
    @IBInspectable var location1: CGFloat = 0.0
    @IBInspectable var location2: CGFloat = 1.0
    
    
    var gradientLayer: CAGradientLayer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyGradientLayer()
    }

    func applyGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        gradientLayer.locations = [location1, location2] as [NSNumber]
        self.layer.addSublayer(gradientLayer)
    }

}
