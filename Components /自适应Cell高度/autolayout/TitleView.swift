//
//  TitleView.swift
//  autolayout
//
//  Created by FanYu on 22/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit
import SnapKit

class TitleView: UIView {
    
    // lazy 用到的时候才去实例化
    private(set) lazy var label = UILabel()
        
    var title: String? {
        didSet {
            label.text = title!
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
        //self.backgroundColor = UIColor.redColor()
        
        // label 
        label.font = UIFont.systemFontOfSize(16)
        label.textColor = UIColor(red:0.02, green:0.6, blue:0.99, alpha:1)
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 80
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // sub 
        self.addSubview(label)
        
        // cons
        label.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self).inset(UIEdgeInsetsMake(1, 1, 1, 1))
        }
        label.setContentHuggingPriority(UILayoutPriorityRequired, forAxis: UILayoutConstraintAxis.Vertical)
    }
    
    override func layoutSubviews() {
        setup() 
    }
}
