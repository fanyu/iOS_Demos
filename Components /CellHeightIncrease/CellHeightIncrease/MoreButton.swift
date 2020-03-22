//
//  MoreButton.swift
//  CellHeightIncrease
//
//  Created by FanYu on 30/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit


class MoreButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.setTitle("More", forState: .Normal)
        self.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.titleLabel?.textAlignment = .Center
        self.backgroundColor = UIColor(red:0.02, green:0.6, blue:0.99, alpha:1)
        //self.addTarget(self, action: "buttonTapped:", forControlEvents: .TouchUpInside)
    }
}
