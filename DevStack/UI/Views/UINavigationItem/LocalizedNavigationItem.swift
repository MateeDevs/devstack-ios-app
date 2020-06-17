//
//  LocalizedNavigationItem.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 13/08/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

open class LocalizedNavigationItem: UINavigationItem {

    override init(title: String) {
        super.init(title: title)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        if let title = title {
            self.title = NSLocalizedString(title, comment: "")
        }
        
        if let backButtonTitle = backBarButtonItem?.title {
            self.backBarButtonItem?.title = NSLocalizedString(backButtonTitle, comment: "")
        }
        
        if let prompt = prompt {
            self.prompt = NSLocalizedString(prompt, comment: "")
        }
    }
    
}
