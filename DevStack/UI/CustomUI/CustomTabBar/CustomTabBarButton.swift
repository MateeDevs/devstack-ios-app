//
//  CustomTabBarButton.swift
//  Shipvio3
//
//  Created by Petr Chmelar on 07/09/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

class CustomTabBarButton: XIBView {
    
    /// required nib name
    override var nibName: String {
        return CustomTabBarButton.nameOfClass
    }
    
    @IBOutlet weak var button: LocalizedButton!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var numberView: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    
}
