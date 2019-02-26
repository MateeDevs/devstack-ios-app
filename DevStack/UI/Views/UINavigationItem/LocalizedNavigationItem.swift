//
//  LocalizedNavigationItem.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 13/08/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

open class LocalizedNavigationItem: UINavigationItem {

    override open func awakeFromNib() {
        super.awakeFromNib()
        
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
