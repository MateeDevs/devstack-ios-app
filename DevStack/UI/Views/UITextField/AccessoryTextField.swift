//
//  AccessoryTextField.swift
//  Shipvio3
//
//  Created by Viktor Kaderabek on 27/08/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

class AccessoryTextField: LocalizedTextField {
    
    var isOkAccessory : Bool = true
    
    lazy var accessoryView: UIView = {
        let accView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        accView.backgroundColor = UIColor.white
        accView.addSubview(okAccessoryButton)
        accView.layer.borderColor = Asset.Colors.greyDark.color.cgColor
        accView.layer.borderWidth = 0.5
        return accView
    }()
    
    lazy var okAccessoryButton :UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: UIScreen.main.bounds.width - 60, y: 0, width: 60, height: 40)
        button.setTitle(L10n.ok, for: .normal)
        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if isOkAccessory {
            inputAccessoryView = accessoryView
        }
    }

}
