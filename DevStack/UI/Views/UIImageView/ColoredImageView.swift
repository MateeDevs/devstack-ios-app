//
//  ColoredImageView.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 31/08/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

@IBDesignable open class ColoredImageView: UIImageView {

    // MARK: UI components

    // MARK: Stored properties
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
    
    @IBInspectable public var borderColor: UIColor = AppTheme.Colors.primaryColor {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable public var imageColor: UIColor = AppTheme.Colors.primaryColor {
        didSet {
            if image != nil {
                image = image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                tintColor = imageColor
            } else {
                image = nil
            }
        }
    }

    // MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: Default methods
    private func setup() {
    }

    // MARK: Additional methods
    
}
