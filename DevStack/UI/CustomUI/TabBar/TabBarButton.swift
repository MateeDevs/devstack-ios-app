//
//  TabBarButton.swift
//  DevStack
//
//  Created by Petr Chmelar on 07/09/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

class TabBarButton: XIBView {
    
    // swiftlint:disable private_outlet
    @IBOutlet weak var button: LocalizedButton!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var numberView: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    // swiftlint:enable private_outlet
}
