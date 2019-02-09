//
//  EnhancedButton.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 30/07/2017.
//  Copyright © 2017 Qest. All rights reserved.
//

import UIKit

@IBDesignable class EnhancedButton: LocalizedButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
            self.layer.masksToBounds = self.cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = self.borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = .black {
        didSet {
            self.layer.borderColor = self.borderColor.cgColor
        }
    }
    
    @IBInspectable var titleLeftPadding: CGFloat = 0.0 {
        didSet {
            self.titleEdgeInsets.left = self.titleLeftPadding
        }
    }
    
    @IBInspectable var titleRightPadding: CGFloat = 0.0 {
        didSet {
            self.titleEdgeInsets.right = self.titleRightPadding
        }
    }
    
    @IBInspectable var titleTopPadding: CGFloat = 0.0 {
        didSet {
            self.titleEdgeInsets.top = self.titleTopPadding
        }
    }
    
    @IBInspectable var titleBottomPadding: CGFloat = 0.0 {
        didSet {
            self.titleEdgeInsets.bottom = self.titleBottomPadding
        }
    }
    
    @IBInspectable var imageLeftPadding: CGFloat = 0.0 {
        didSet {
            self.imageEdgeInsets.left = self.imageLeftPadding
        }
    }
    
    @IBInspectable var imageRightPadding: CGFloat = 0.0 {
        didSet {
            self.imageEdgeInsets.right = self.imageRightPadding
        }
    }
    
    @IBInspectable var imageTopPadding: CGFloat = 0.0 {
        didSet {
            self.imageEdgeInsets.top = self.imageTopPadding
        }
    }
    
    @IBInspectable var imageBottomPadding: CGFloat = 0.0 {
        didSet {
            self.imageEdgeInsets.bottom = self.imageBottomPadding
        }
    }
    
    @IBInspectable var enableImageRightAligned: Bool = false
    
    @IBInspectable var enableGradientBackground: Bool = false
    @IBInspectable var enableGradientStyleHorizontal: Bool = false
    
    @IBInspectable var gradientColor1: UIColor = UIColor.black
    @IBInspectable var gradientColor2: UIColor = UIColor.white
    @IBInspectable var gradientColorDisabled1: UIColor = UIColor.black
    @IBInspectable var gradientColorDisabled2: UIColor = UIColor.white
    
    fileprivate var gradientLayer: CAGradientLayer = CAGradientLayer()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.enableImageRightAligned, let imageView = self.imageView {
            self.imageEdgeInsets.left = self.bounds.width - imageView.bounds.width - self.imageRightPadding
        }
        
        if self.enableGradientBackground {
            self.gradientLayer.removeFromSuperlayer()
            self.gradientLayer = CAGradientLayer()
            self.gradientLayer.frame = self.bounds
            if self.isEnabled {
                self.gradientLayer.colors = [self.gradientColor1.cgColor, self.gradientColor2.cgColor]
            } else {
                self.gradientLayer.colors = [self.gradientColorDisabled1.cgColor, self.gradientColorDisabled2.cgColor]
            }
            if self.enableGradientStyleHorizontal {
                self.gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
                self.gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            } else {
                self.gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
                self.gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
            }
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
    
    @IBInspectable var imageColor: UIColor = UIColor.black {
        didSet {
            if currentImage != nil {
                setImage(currentImage?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
                tintColor = imageColor
            } else {
                setImage(nil, for: .normal)
            }
        }
    }
    
}
