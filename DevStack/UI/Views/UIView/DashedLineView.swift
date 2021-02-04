//
//  DashedLineView.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 25/09/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

@IBDesignable open class DashedLineView: UIView {

    // MARK: UI components

    // MARK: Stored properties
    @IBInspectable public var lineColor: UIColor = AppTheme.Colors.separator
    @IBInspectable public var lineLength: CGFloat = 6
    @IBInspectable public var lineGap: CGFloat = 3

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
    
    override open func draw(_ rect: CGRect) {
        // Graphics context
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        // Line points
        let p0 = CGPoint(x: bounds.minX, y: bounds.minY)
        let p1 = CGPoint(x: bounds.maxX, y: bounds.minY)
        
        // Line drawing
        context.move(to: p0)
        context.addLine(to: p1)
        
        // Line property
        context.setLineDash(phase: 0.0, lengths: [lineLength, lineGap])
        context.setLineWidth(bounds.height * 2)
        context.setLineCap(.butt)
        lineColor.set()
        
        // Draw a line
        context.strokePath()
    }

    // MARK: Additional methods
    
}
