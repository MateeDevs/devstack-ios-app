// 
//  UserTableViewCell.swift
//  DevStack
//
//  Created by Petr Chmelar on 09/02/2019.
//  Copyright © 2019 Qest. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    static let prefferedHeight: CGFloat = 44.0
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func setupWithUser(_ user: User) {
        nameLabel.text = user.fullName
    }
}
