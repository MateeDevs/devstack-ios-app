//
//  BaseTableViewCell.swift
//  DevStack
//
//  Created by Petr Chmelar on 27/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import UIKit

@IBDesignable open class BaseTableViewCell: UITableViewCell {
    
    public static let prefferedHeight: CGFloat = 44.0
    
    @IBInspectable public var showDefaultSeparator: Bool = true {
        didSet {
            separator.isHidden = showDefaultSeparator
        }
    }
    
    @IBInspectable public var separatorColor: UIColor = AppTheme.Colors.separator {
        didSet {
            separator.backgroundColor = separatorColor
        }
    }
    
    private var separator = UIView()
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        addSeparator()
    }
    
    private func addSeparator() {
        contentView.addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0).isActive = true
        separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }

}
