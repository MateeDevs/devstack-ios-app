//
//  UserImageView.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 12/09/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import AlamofireImage
import UIKit

@IBDesignable public class UserImageView: XIBView {

    // MARK: UI components
    @IBOutlet private weak var placeholderView: UIView! {
        didSet {
            placeholderView.layer.borderWidth = 3
        }
    }
    @IBOutlet private weak var placeholderLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!

    @IBInspectable public var placeholderTextColor: UIColor = .white {
        didSet {
            placeholderLabel.textColor = placeholderTextColor
            placeholderView.layer.borderColor = placeholderTextColor.cgColor
        }
    }

    @IBInspectable public var placeholderBackgroundColor: UIColor = AppTheme.Colors.primaryColor {
        didSet {
            placeholderView.backgroundColor = placeholderBackgroundColor
        }
    }

    // MARK: Stored properties
    public var placeholder: String? {
        didSet {
            placeholderLabel.text = placeholder
        }
    }

    public var image: UIImage? {
        didSet {
            imageView.image = image
            placeholderView.layer.borderWidth = 0
        }
    }

    public var imageURL: String? {
        didSet {
            guard let imageURL = imageURL, let url = URL(string: imageURL) else { return }
            imageView.af.setImage(withURL: url)
            placeholderView.layer.borderWidth = 0
        }
    }

    // MARK: Inits

    // MARK: Default methods
    override public func configureViews() {
        super.configureViews()

        layoutIfNeeded()
        setDimensions()
        backgroundColor = .clear

        view.isSkeletonable = true
        placeholderView.isSkeletonable = true
    }

    // MARK: Additional methods
    private func setDimensions() {
        placeholderView.layer.cornerRadius = placeholderView.frame.size.width / 2.0
        placeholderLabel.font = UIFont.systemFont(ofSize: placeholderView.frame.size.width / 2.85, weight: .medium)
    }

}
