//
//  DropDownSelectorCell.swift
//  Shipvio3
//
//  Created by Viktor Kaderabek on 31/08/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

class DropDownSelectorCell: UITableViewCell {

    static let recommendedCellHeight: CGFloat = 40.0
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
