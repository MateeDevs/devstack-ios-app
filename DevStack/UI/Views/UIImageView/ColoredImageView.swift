//
//  ColoredImageView.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 31/08/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

@IBDesignable open class ColoredImageView: UIImageView {
    
    @IBInspectable public var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable public var borderColor: UIColor = ColorTheme.primaryColor {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable public var imageColor: UIColor = ColorTheme.primaryColor {
        didSet {
            if image != nil {
                image = image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                tintColor = imageColor
            } else {
                image = nil
            }
        }
    }
    
}
