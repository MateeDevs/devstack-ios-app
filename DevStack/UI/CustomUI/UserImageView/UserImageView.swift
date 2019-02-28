//
//  UserImageView.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 12/09/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit
import AlamofireImage

public class UserImageView: XIBView {
    
    @IBOutlet private weak var userPlaceHolderView: UIView!
    @IBOutlet private weak var initialsLabel: UILabel!
    @IBOutlet private weak var userImageView: UIImageView!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        layoutIfNeeded()
        setDimensions()
    }
    
    convenience public init(user: User) {
        self.init()
        setupWithUser(user)
        setDimensions()
    }
    
    convenience public init(string: String) {
        self.init()
        setupWithString(string)
        setDimensions()
    }
    
    private func setupWithUser(_ user: User) {
        //guard let pictureUrl = user.pictureUrl, let url = URL(string: pictureUrl) else { return }
        //userImageView.af_setImage(withURL: url)
        initialsLabel.text = DataFormatter.userInitials(from: user.fullName)
        userPlaceHolderView.backgroundColor = .lightGray
    }
    
    private func setupWithString(_ string: String) {
        initialsLabel.text = DataFormatter.userInitials(from: string)
        userPlaceHolderView.backgroundColor = .lightGray
    }
    
    private func setDimensions() {
        userPlaceHolderView.layer.cornerRadius = userPlaceHolderView.frame.size.width / 2.0
        initialsLabel.font = UIFont.systemFont(ofSize: userPlaceHolderView.frame.size.width / 2.85, weight: .medium)
    }

}
