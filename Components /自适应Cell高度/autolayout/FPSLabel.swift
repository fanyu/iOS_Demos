//
//  FPSLabel.swift
//  autolayout
//
//  Created by FanYu on 27/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class FPSLabel: UILabel {

    private var link = CADisplayLink()
    private var lastTime: NSTimeInterval = 0
    private var count: Double = 0
    var fps: Double = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        // self
        self.textColor = UIColor.orangeColor()
        self.textAlignment = .Center

        link = CADisplayLink(target: self, selector: #selector(FPSLabel.tick(_:)))
        link.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    func tick(sender: CADisplayLink) {
        
        if lastTime == 0 {
            lastTime = link.timestamp
            return
        }
        
        count += 1
        
        let delta = link.timestamp - lastTime
        if delta < 1 { return }
        
        lastTime = link.timestamp
        
        let fps = count / delta
        count = 0
        
        self.text  = "\(Int(fps))"
        
        self.fps = fps
        
        print("FramePerSecond : \(fps)")
    }
}
