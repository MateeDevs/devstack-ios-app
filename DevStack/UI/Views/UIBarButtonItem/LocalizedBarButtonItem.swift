//
//  LocalizedBarButtonItem.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 25/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

open class LocalizedBarButtonItem: UIBarButtonItem {

    // MARK: UI components
    
    // MARK: Stored properties

    // MARK: Inits
    override init() {
        super.init()
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: Default methods
    private func setup() {
        if let title = self.title {
            self.title = NSLocalizedString(title, comment: "")
        }
    }

    // MARK: Additional methods
    
}
