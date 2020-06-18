//
//  TextFieldWithHint.swift
//  DevStack
//
//  Created by Petr Chmelar on 04/01/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import UIKit

@IBDesignable open class TextFieldWithHint: UIView {
    
    public let textField = UITextField()
    
    // swiftlint:disable:next private_outlet
    @IBOutlet public weak var delegate: UITextFieldDelegate?
    
    private let hintLabel = UILabel()
    
    @IBInspectable public var hint: String = "" {
        didSet {
            hintLabel.text = NSLocalizedString(hint, comment: "")
        }
    }
    
    @IBInspectable public var autocorrectionType: Bool = true {
        didSet {
            textField.autocorrectionType = autocorrectionType ? .yes : .no
        }
    }
    
    @IBInspectable public var spellCheckingType: Bool = true {
        didSet {
            textField.spellCheckingType = spellCheckingType ? .yes : .no
        }
    }
    
    @IBInspectable public var isSecureTextEntry: Bool = false {
        didSet {
            textField.isSecureTextEntry = isSecureTextEntry
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        // Setup a hint label
        hintLabel.textColor = AppTheme.Colors.textFieldHint
        hintLabel.font = AppTheme.Fonts.textFieldHint
        
        addSubview(hintLabel)
        hintLabel.translatesAutoresizingMaskIntoConstraints = false
        hintLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        hintLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        hintLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        
        // Setup a view with a border around the text field
        let textFieldView = UIView()
        textFieldView.layer.borderWidth = 2.0
        textFieldView.layer.borderColor = AppTheme.Colors.textFieldBorder.cgColor
        
        addSubview(textFieldView)
        textFieldView.translatesAutoresizingMaskIntoConstraints = false
        textFieldView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        textFieldView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        textFieldView.topAnchor.constraint(equalTo: hintLabel.bottomAnchor, constant: 4).isActive = true
        textFieldView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        // Setup a text field
        textField.font = AppTheme.Fonts.textField
        textField.borderStyle = .none
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .done
        textField.textContentType = UITextContentType(rawValue: "")
        delegate = textField.delegate
        
        textFieldView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor, constant: 8).isActive = true
        textField.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -8).isActive = true
        textField.topAnchor.constraint(equalTo: textFieldView.topAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: textFieldView.bottomAnchor).isActive = true
    }
    
}
