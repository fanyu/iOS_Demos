//
//  TwinkleLayer.swift
//  TwinkleDemo
//
//  Created by FanYu on 20/10/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class TwinkleLayer: CAEmitterLayer {
    
    override init() {
        super.init()
        
        let twinkleImage = UIImage(named: "TwinkleImage")
        
        let emitterCells = [CAEmitterCell(), CAEmitterCell()]
        for cell in emitterCells {
            cell.birthRate = 8  // created every second 
            cell.lifetime = 1.25    // when particles are created
            cell.lifetimeRange = 0
            cell.emissionRange = CGFloat(M_PI_4)    // 1 / 4 * pi
            cell.velocity = 2
            cell.velocityRange = 1.8
            cell.scale = 0.65
            cell.scaleRange = 0.7
            cell.scaleSpeed = 0.6
            cell.spin = 0.9
            cell.spinRange = CGFloat(M_PI)
            cell.color = UIColor(white: 1, alpha: 0.3).CGColor
            cell.alphaSpeed = -0.8
            cell.contents = twinkleImage?.CGImage
            cell.magnificationFilter = "linear"
            cell.minificationFilter = "trilinear"
            cell.enabled = true
        }
        
        self.emitterCells = emitterCells
        
        self.emitterPosition = CGPoint(x: bounds.size.width * 0.5, y: bounds.size.height * 0.5)
        self.emitterSize = bounds.size
        
        self.emitterShape = "circle"
        self.emitterMode = "surface"
        self.renderMode = "unordered"
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


extension TwinkleLayer {
    
    func positionAnimation() {
        CATransaction.begin()
        let keyFrameAnim = CAKeyframeAnimation(keyPath: "position")
        keyFrameAnim.duration = 0.3
        keyFrameAnim.additive = true
        keyFrameAnim.repeatCount = MAXFLOAT
        keyFrameAnim.removedOnCompletion = false
        keyFrameAnim.beginTime = CFTimeInterval(arc4random_uniform(1000) + 1) * 0.2 * 0.25 // random start time
    }
}






