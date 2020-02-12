//
//  ShadowView.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 27/08/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

open class ShadowView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        layer.shadowColor = UIColorCompatible.systemGray4.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 2
    }

}
