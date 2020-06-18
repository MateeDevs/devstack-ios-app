//
//  LocalizedImageView.swift
//  DevStack
//
//  Created by Petr Chmelar on 24/10/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

open class LocalizedImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        image = image?.imageFlippedForRightToLeftLayoutDirection()
    }
    
}
