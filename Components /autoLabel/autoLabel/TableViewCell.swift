//
//  TableViewCell.swift
//  autoLabel
//
//  Created by FanYu on 17/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = 200
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
