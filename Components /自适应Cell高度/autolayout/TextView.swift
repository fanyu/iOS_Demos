//
//  TextView.swift
//  autolayout
//
//  Created by FanYu on 22/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit
import SnapKit

class TextView: UIView {
    
    private(set) lazy var label = UILabel()
    
    var text: String? {
        didSet {
            label.text = text!
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        // self 
        //self.backgroundColor = UIColor.yellowColor()
        
        // label 
        label.font = UIFont.systemFontOfSize(16)
        label.textColor = UIColor.blackColor()
        label.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 80
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // sub 
        self.addSubview(label)
        
        // constraint 
        label.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1))
        }
        label.contentHuggingPriorityForAxis(UILayoutConstraintAxis.Vertical)
    }
}
