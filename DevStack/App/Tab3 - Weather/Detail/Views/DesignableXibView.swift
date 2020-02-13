//
//  DesignableXibView.swift
//  DevStack
//
//  Created by Filip Bodnár on 13/02/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import UIKit

//@IBDesignable

class DesignableXibView: XIBView {
    @IBOutlet var contentView: UIView!

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
}

