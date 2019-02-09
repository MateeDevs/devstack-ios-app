//
//  ItemInputView.swift
//  Shipvio3
//
//  Created by Viktor Kaderabek on 30/08/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

class ItemInputView: XIBView {
    
    override var nibName: String {
        return ItemInputView.nameOfClass
    }
    
    @IBOutlet weak var titleLabel: LocalizedLabel!
    @IBOutlet weak var backgroundEnabledView: UIView! {
        didSet {
            backgroundEnabledView.layer.borderColor = Asset.Colors.inputViewBorderColor.color.cgColor
            backgroundEnabledView.layer.borderWidth = 2.0
        }
    }
    @IBOutlet weak var backgroundDisabledView: UIView! {
        didSet {
            backgroundDisabledView.layer.borderWidth = 0.0
        }
    }
    
    @IBOutlet weak var inputTextField: LocalizedTextField! {
        didSet {
            inputTextField.pasteActionEnabled = false
        }
    }
    
    var isEnabled : Bool = true {
        didSet {
            backgroundEnabledView.isHidden = !isEnabled
            backgroundDisabledView.isHidden = isEnabled
            inputTextField.isEnabled = isEnabled
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
