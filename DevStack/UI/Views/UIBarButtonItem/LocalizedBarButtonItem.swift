//
//  LocalizedBarButtonItem.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 25/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

open class LocalizedBarButtonItem: UIBarButtonItem {
    
    override init() {
        super.init()
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        if let title = self.title {
            self.title = NSLocalizedString(title, comment: "")
        }
    }
    
}
