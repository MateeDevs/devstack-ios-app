// 
//  ForecastTableViewCell.swift
//  DevStack
//
//  Created by Filip Bodnár on 11/02/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import UIKit

class ForecastTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func setup(_ name: String) {
//        print("clima", clima)
        nameLabel.text = name
    }
}
