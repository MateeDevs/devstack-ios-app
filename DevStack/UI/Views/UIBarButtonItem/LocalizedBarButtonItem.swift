//
//  LocalizedBarButtonItem.swift
//  Shipvio3
//
//  Created by Viktor Kaderabek on 25/07/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

class LocalizedBarButtonItem: UIBarButtonItem {
    override func awakeFromNib() {
        super.awakeFromNib()
        if let title = self.title {
            self.title = NSLocalizedString(title, comment: "")
        }
    }
}
