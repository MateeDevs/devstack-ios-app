//
//  LocalizedBarButtonItem.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 25/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

open class LocalizedBarButtonItem: UIBarButtonItem {
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        if let title = self.title {
            self.title = NSLocalizedString(title, comment: "")
        }
    }
    
}
