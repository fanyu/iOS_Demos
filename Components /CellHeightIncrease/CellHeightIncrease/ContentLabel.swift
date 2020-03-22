//
//  ContentLabel.swift
//  CellHeightIncrease
//
//  Created by FanYu on 30/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class ContentLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.textColor = UIColor(red:0.02, green:0.6, blue:0.99, alpha:1)
        self.numberOfLines = 0
        self.lineBreakMode = NSLineBreakMode.ByCharWrapping
        self.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 20
        self.text = "因为在计算的时候，我们的高度是由一个“template cell”填充内容后计算得来，这个时候的高度已经是展开以后的高度，当前的Cell还来不及调整约束（甚至不会调整，如果只用beginUpdates和endUpdates更新的话，Cell不会reload），所以降低这个高度约束的优先级，去掉冲突。"
    }
}
