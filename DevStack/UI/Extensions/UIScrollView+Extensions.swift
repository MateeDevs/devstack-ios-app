//
//  UIScrollView+Extensions.swift
//  Shipvio3
//
//  Created by Petr Chmelar on 11/09/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    func isNearBottomEdge(edgeOffset: CGFloat = 100.0) -> Bool {
        return self.contentOffset.y + self.frame.size.height + edgeOffset > self.contentSize.height
    }
    
    func isOverTopEdge(edgeOffset: CGFloat = -10.0) -> Bool {
        return self.contentOffset.y < edgeOffset
    }
    
}
