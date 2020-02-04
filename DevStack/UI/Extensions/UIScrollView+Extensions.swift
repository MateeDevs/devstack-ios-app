//
//  UIScrollView+Extensions.swift
//  DevStack
//
//  Created by Petr Chmelar on 11/09/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    public func isNearBottomEdge(edgeOffset: CGFloat = 100.0) -> Bool {
        contentOffset.y + frame.size.height + edgeOffset > contentSize.height
    }
    
    public func isOverTopEdge(edgeOffset: CGFloat = -10.0) -> Bool {
        contentOffset.y < edgeOffset
    }
    
}
