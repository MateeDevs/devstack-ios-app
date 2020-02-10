//
//  UserImageView.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 12/09/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit
import AlamofireImage

@IBDesignable public class UserImageView: XIBView {
    
    @IBOutlet private weak var userPlaceHolderView: UIView!
    @IBOutlet private weak var initialsLabel: UILabel!
    @IBOutlet private weak var userImageView: UIImageView!
    
    @IBInspectable public var placeholderTextColor: UIColor = .white {
        didSet {
            initialsLabel.textColor = placeholderTextColor
        }
    }
    
    @IBInspectable public var placeholderBackgroundColor: UIColor = AppTheme.Colors.primaryColor {
        didSet {
            userPlaceHolderView.backgroundColor = placeholderBackgroundColor
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        layoutIfNeeded()
        setDimensions()
        backgroundColor = .clear
        
        view.isSkeletonable = true
        userPlaceHolderView.isSkeletonable = true
    }
    
    public func setupWithUser(_ user: User?) {
        guard let user = user else { return }
        initialsLabel.text = user.fullName.initials
        if let pictureUrl = user.pictureUrl, let url = URL(string: pictureUrl) {
            userImageView.af_setImage(withURL: url)
        }
    }
    
    private func setDimensions() {
        userPlaceHolderView.layer.cornerRadius = userPlaceHolderView.frame.size.width / 2.0
        initialsLabel.font = UIFont.systemFont(ofSize: userPlaceHolderView.frame.size.width / 2.85, weight: .medium)
    }

}
