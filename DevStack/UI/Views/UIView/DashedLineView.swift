//
//  DashedLineView.swift
//  Shipvio3
//
//  Created by Viktor Kaderabek on 25/09/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

@IBDesignable class DashedLineView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBInspectable var lineColor: UIColor = Asset.Colors.mainBackground.color
    @IBInspectable var lineLenght: CGFloat = 6
    @IBInspectable var lineGap: CGFloat = 3
    
    override func draw(_ rect: CGRect) {
        // Graphics context
        let  context: CGContext = UIGraphicsGetCurrentContext()!
        
        // Line points
        let p0 = CGPoint(x: bounds.minX, y: bounds.minY)
        let p1 = CGPoint(x: bounds.maxX, y: bounds.minY)
        
        // Line drawing
        context.move(to: p0)
        context.addLine(to: p1)
        
        // Line property
        context.setLineDash(phase: 0.0, lengths: [lineLenght, lineGap])
        context.setLineWidth(bounds.height * 2)
        context.setLineCap(.butt)
        lineColor.set()
        
        // Draw a line
        context.strokePath()
    }
    
}
