//
//  UserImageView.swift
//  Shipvio3
//
//  Created by Viktor Kaderabek on 12/09/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit
import AlamofireImage

class UserImageView: XIBView {
    
    @IBInspectable var widthMultiplier: CGFloat = 1.0 {
        didSet {
            widthConstraint = widthConstraint.cloneWithMultiplier(multiplier: widthMultiplier)
            setDimensions()
        }
    }
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var userPlaceHolderView: UIView!
    @IBOutlet weak var initialsLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    override var nibName: String {
        return UserImageView.nameOfClass
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutIfNeeded()
        setDimensions()
    }
    
    convenience init(user: User) {
        self.init()
        setupWithUser(user)
        setDimensions()
    }
    
    convenience init(string: String) {
        self.init()
        setupWithString(string)
        setDimensions()
    }
    
    func setupWithUser(_ user: User) {
        guard let pictureUrl = user.pictureUrl, let url = URL(string: pictureUrl) else { return }
        userImageView.af_setImage(withURL: url)
        self.initialsLabel.text = CustomDataFormatter.userInitials(from: user.fullName)
        setAppearance(isCountPlaceholder: false)
    }
    
    func setupWithString(_ string: String) {
        self.initialsLabel.text = CustomDataFormatter.userInitials(from: string)
        setAppearance(isCountPlaceholder: true)
    }
    
    func setAppearance(isCountPlaceholder: Bool) {
        if isCountPlaceholder {
            self.userPlaceHolderView.backgroundColor = UIColor.clear
        } else {
            self.userPlaceHolderView.backgroundColor = Asset.Colors.greyLight.color
        }
    }
    
    func setDimensions() {
        userPlaceHolderView.layer.cornerRadius = (userPlaceHolderView.frame.size.width * widthMultiplier) / 2.0
        initialsLabel.font = UIFont.systemFont(ofSize: userPlaceHolderView.frame.size.width / 2.85, weight: .medium)
    }

}
