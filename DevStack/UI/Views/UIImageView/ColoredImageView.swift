//
//  ColoredImageView.swift
//  Shipvio3
//
//  Created by Viktor Kaderabek on 31/08/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

@IBDesignable class ColoredImageView: UIImageView {
    
    @IBInspectable var cornerRadius : CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = cornerRadius > 0
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
    
    @IBInspectable var imageColor : UIColor = UIColor.black {
        didSet {
            if image != nil {
                // signal value -> If clear color then set the original image color
                if imageColor == UIColor.clear {
                    image = image?.withRenderingMode(.alwaysOriginal)
                } else {
                    image = image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                    tintColor = imageColor
                }
            } else {
                image = nil
            }
        }
    }
    
}
