//
//  LocalizedNavigationItem.swift
//  Shipvio3
//
//  Created by Viktor Kaderabek on 13/08/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

class LocalizedNavigationItem: UINavigationItem {

    override func awakeFromNib() {
        super.awakeFromNib()
        if let title = self.title {
            self.title = NSLocalizedString(title, comment: "")
        }
        if let backButtonTitle = self.backBarButtonItem?.title {
            self.backBarButtonItem?.title = NSLocalizedString(backButtonTitle, comment: "")
        }
        if let prompt = self.prompt {
            self.prompt = NSLocalizedString(prompt, comment: "")
        }
    }
    
}
