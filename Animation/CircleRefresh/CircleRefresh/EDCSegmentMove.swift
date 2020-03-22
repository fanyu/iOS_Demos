//
//  EDCSegmentMove.swift
//  CircleRefresh
//
//  Created by FanYu on 5/1/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

class EDCSegmentMove: CALayer {
    
    private(set) var lineWidth: CGFloat = 6
    private(set) var shapeLayer = CAShapeLayer()
    private(set) var path = UIBezierPath()
    
    let animationStart: CABasicAnimation = {
        let ani = CABasicAnimation(keyPath: "strokeStart")
        ani.fromValue = 0
        ani.toValue = 0.9
        ani.setValue("start", forKey: "name")
        return ani
    }()
    
    let animationEnd: CABasicAnimation = {
        let ani = CABasicAnimation(keyPath: "strokeEnd")
        ani.fromValue = 0.1
        ani.toValue = 1
        return ani
    }()
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers() {
        setup()
    }
    
    private func setup() {
        
        // line path
        path.moveToPoint(CGPoint(x: 0, y: 0))
        path.addLineToPoint(CGPoint(x: 100, y: 0))
        path.closePath()
        
        // shape
        shapeLayer.lineWidth = lineWidth
        shapeLayer.path = path.CGPath
        shapeLayer.fillColor = UIColor.redColor().CGColor
        shapeLayer.strokeColor = UIColor(red:0.02, green:0.6, blue:0.99, alpha:1).CGColor
        shapeLayer.autoreverses = false
        
        self.addSublayer(shapeLayer)
        
        let anis = CAAnimationGroup()
        anis.animations = [animationStart, animationEnd]
        anis.duration = 5
        anis.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        //anis.repeatCount = HUGE
        
        self.shapeLayer.addAnimation(anis, forKey: "segment")
    }

}
