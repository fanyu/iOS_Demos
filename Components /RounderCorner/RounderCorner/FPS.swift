//
//  FPS.swift
//  RounderCorner
//
//  Created by FanYu on 1/3/2016.
//  Copyright © 2016 FanYu. All rights reserved.
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
        self.textColor = UIColor.whiteColor()
        self.textAlignment = .Center
        self.backgroundColor = UIColor(red:0.95, green:0.25, blue:0.51, alpha:1)
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        link = CADisplayLink(target: self, selector: "tick:")
        link.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    func tick(sender: CADisplayLink) {
        
        if lastTime == 0 {
            lastTime = link.timestamp
            return
        }
        
        count++
        
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
