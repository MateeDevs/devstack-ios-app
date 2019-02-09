//
//  LocalizedViewController.swift
//  Shipvio3
//
//  Created by Petr Chmelar on 19/07/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

class LocalizedViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Title localization
        if let title = navigationItem.title {
            navigationItem.title = NSLocalizedString(title, comment: "")
        }
    }
    
}
