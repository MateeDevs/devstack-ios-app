//
//  EnhancedButton.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 30/07/2017.
//  Copyright © 2017 Matee. All rights reserved.
//

import UIKit

@IBDesignable open class EnhancedButton: LocalizedButton {
    
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
    
    @IBInspectable public var titleLeftPadding: CGFloat = 0.0 {
        didSet {
            titleEdgeInsets.left = titleLeftPadding
        }
    }
    
    @IBInspectable public var titleRightPadding: CGFloat = 0.0 {
        didSet {
            titleEdgeInsets.right = titleRightPadding
        }
    }
    
    @IBInspectable public var titleTopPadding: CGFloat = 0.0 {
        didSet {
            titleEdgeInsets.top = titleTopPadding
        }
    }
    
    @IBInspectable public var titleBottomPadding: CGFloat = 0.0 {
        didSet {
            titleEdgeInsets.bottom = titleBottomPadding
        }
    }
    
    @IBInspectable public var imageLeftPadding: CGFloat = 0.0 {
        didSet {
            imageEdgeInsets.left = imageLeftPadding
        }
    }
    
    @IBInspectable public var imageRightPadding: CGFloat = 0.0 {
        didSet {
            imageEdgeInsets.right = imageRightPadding
        }
    }
    
    @IBInspectable public var imageTopPadding: CGFloat = 0.0 {
        didSet {
            imageEdgeInsets.top = imageTopPadding
        }
    }
    
    @IBInspectable public var imageBottomPadding: CGFloat = 0.0 {
        didSet {
            imageEdgeInsets.bottom = imageBottomPadding
        }
    }
    
    @IBInspectable public var imageColor: UIColor = ColorTheme.primaryColor {
        didSet {
            if currentImage != nil {
                setImage(currentImage?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
                tintColor = imageColor
            } else {
                setImage(nil, for: .normal)
            }
        }
    }
    
    @IBInspectable public var enableImageRightAligned: Bool = false
    
    @IBInspectable public var enableGradientBackground: Bool = false
    @IBInspectable public var enableGradientStyleHorizontal: Bool = false
    
    @IBInspectable public var gradientColor1: UIColor = .systemRed
    @IBInspectable public var gradientColor2: UIColor = .systemBlue
    @IBInspectable public var gradientColorDisabled1: UIColor = .systemRed
    @IBInspectable public var gradientColorDisabled2: UIColor = .systemBlue
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if enableImageRightAligned, let imageView = imageView {
            imageEdgeInsets.left = bounds.width - imageView.bounds.width - imageRightPadding
        }
        
        if enableGradientBackground {
            setupGradient()
        }
    }
    
    private func setupGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        if isEnabled {
            gradientLayer.colors = [gradientColor1.cgColor, gradientColor2.cgColor]
        } else {
            gradientLayer.colors = [gradientColorDisabled1.cgColor, gradientColorDisabled2.cgColor]
        }
        
        if enableGradientStyleHorizontal {
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        } else {
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        }
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
