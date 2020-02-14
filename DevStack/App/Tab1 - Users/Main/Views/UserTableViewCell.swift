// 
//  UserTableViewCell.swift
//  DevStack
//
//  Created by Petr Chmelar on 09/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import UIKit

class UserTableViewCell: BaseTableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!

    func setupWithUser(_ user: User) {
        nameLabel.text = user.fullName
    }
}
