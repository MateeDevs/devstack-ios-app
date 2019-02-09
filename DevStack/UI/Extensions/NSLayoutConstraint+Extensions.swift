//
//  NSLayoutConstraint+Extensions.swift
//  Shipvio3
//
//  Created by Petr Chmelar on 01/10/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation
import UIKit

extension NSLayoutConstraint {

    ///
    /// Change constraint's multiplier
    ///
    /// - parameter multiplier: CGFloat value of multiplier
    /// - returns: NSLayoutConstraint with a given multiplier
    ///
    func cloneWithMultiplier(multiplier: CGFloat) -> NSLayoutConstraint? {
        
        guard let firstItemNotNill = firstItem, let secondItemNotNill = secondItem else {
            return nil
        }
        
        NSLayoutConstraint.deactivate([self])
        
        let newConstraint = NSLayoutConstraint(
            item: firstItemNotNill,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItemNotNill,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}
