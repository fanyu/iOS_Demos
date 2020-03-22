//
//  EDCRightMarkLayer.swift
//  CircleRefresh
//
//  Created by FanYu on 6/1/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

// 对勾图像
class EDCRightMarkLayer: CALayer {

    private let path = UIBezierPath()
    private var shapeLayer = CAShapeLayer()
    private let radius: CGFloat = 40
    private let lineWidth: CGFloat = 6
    
    let animation = CABasicAnimation(keyPath: "strokeEnd")

    override init() {
        super.init()
        animation.delegate = self 
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers() {
        //print(self.bounds)
        setup()
    }
    
    private func setup() {
        // path 
        let centerPoint = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))
        
        // 1st point
        var firstPoint = centerPoint
        firstPoint.x -= radius / 2
        path.moveToPoint(firstPoint)
        
        // 2ed point 
        var secondPoint = centerPoint
        secondPoint.x -= radius / 8
        secondPoint.y += radius / 2
        path.addLineToPoint(secondPoint)
        
        // 3rd point 
        var thirdPoint = centerPoint
        thirdPoint.x += radius / 2
        thirdPoint.y -= radius / 2
        path.addLineToPoint(thirdPoint)
        
        // shape layer 
        shapeLayer.path = path.CGPath
        shapeLayer.lineWidth = lineWidth
        shapeLayer.strokeColor = UIColor.redColor().CGColor
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = 1
        self.addSublayer(shapeLayer)
        
        // animation 
        animation.duration = 2
        animation.fromValue = 0
        animation.toValue = 1
        shapeLayer.addAnimation(animation, forKey: "End")
        
        animation.setValue("RightMark", forKey: "Name")
        animation.delegate = self
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        print("Right Stop")
    }
}
