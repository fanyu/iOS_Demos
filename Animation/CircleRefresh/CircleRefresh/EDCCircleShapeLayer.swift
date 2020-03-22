//
//  EDCCircleRefreshLayer.swift
//  CircleRefresh
//
//  Created by FanYu on 5/1/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

class EDCCircleShapeLayer: CALayer {
    
    private let lineWidth: CGFloat = 6
    private let path = UIBezierPath()
    private let shapeLayer = CAShapeLayer()
    let anims = CAAnimationGroup()

    
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSublayers() {
    }
    
    // 涉及到旋转，不可以在layoutsublayers里面执行，否则z 轴就变了
    private func setup() {
        
        // path
        let center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))
        let raidus: CGFloat = 50 // CGRectGetHeight(self.bounds) / 2 - lineWidth / 2
        
        path.addArcWithCenter(center, radius: raidus, startAngle: 0, endAngle: CGFloat(M_PI * 2.0), clockwise: false)
        
        // shape layer
        shapeLayer.path = path.CGPath
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.strokeColor = UIColor(red:0.02, green:0.6, blue:0.99, alpha:1).CGColor
        self.addSublayer(shapeLayer)
        
        // animation
        let startAnim = CABasicAnimation(keyPath: "strokeStart")
        startAnim.fromValue = 0.25
        startAnim.toValue = 0
        
        let endAnim = CABasicAnimation(keyPath: "strokeEnd")
        endAnim.fromValue = 0.5
        endAnim.toValue = 1.0

        let rotateAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        rotateAnim.fromValue = 0
        rotateAnim.toValue = -(M_PI * 2.0)
        
        //let anims = CAAnimationGroup()
        anims.animations = [startAnim, endAnim, rotateAnim]
        anims.duration = 3
        //anims.repeatCount = HUGE
        
        anims.setValue("CircleShape", forKey: "Name")
        anims.delegate = self
        
        shapeLayer.addAnimation(anims, forKey: "three of them")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        print("CircleShape End")
    }
}

