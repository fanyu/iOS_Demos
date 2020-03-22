//
//  TableViewCell.swift
//  ParallaxHeader
//
//  Created by FanYu on 28/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    var labelStr: String? {
        didSet {
            self.label.text = labelStr!
        }
    }
    
    private lazy var label = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        // self 
        self.backgroundColor = UIColor(red:0.02, green:0.6, blue:0.99, alpha:1)
        self.selectionStyle = .None

        // label 
        self.label.textAlignment = .Center
        self.label.textColor = UIColor.whiteColor()
        self.label.translatesAutoresizingMaskIntoConstraints = false
        
        // sub 
        self.addSubview(label)
        
        // constraint 
        label.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.contentView).inset(UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
        }
    }
}
