//
//  EDCContactCell.swift
//  ContactIndext
//
//  Created by FanYu on 8/1/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

class EDCContactCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        self.selectionStyle = .None
    }
}
