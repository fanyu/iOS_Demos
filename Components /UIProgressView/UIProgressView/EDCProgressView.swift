//
//  EDCProgressView.swift
//  UIProgressView
//
//  Created by FanYu on 3/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class EDCProgressView: UIProgressView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        print(111)
        self.backgroundColor = UIColor.whiteColor()
        self.progressTintColor = UIColor.orangeColor()
        self.setProgress(0.6, animated: true)
    }
    
    override func layoutSubviews() {
        
    }
}
