//
//  CircleView.swift
//  PullToRefreshDemo
//
//  Created by FanYu on 31/10/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class CircleView: UIView {

    let circleLayer: CAShapeLayer = {
        let shape = CAShapeLayer()
        shape.lineWidth = 5
        shape.fillColor = UIColor.clearColor().CGColor
        shape.strokeColor = UIColor.whiteColor().CGColor
        return shape
    }()
    
    let strokeEndAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        animation.autoreverses = true
        return animation
    }()
    
    
    let autoStrkeAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 1
        animation.autoreverses = true
        return animation
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        circleLayer.addAnimation(strokeEndAnimation, forKey: "Stroke End")
        self.layer.addSublayer(circleLayer)
        
        self.layer.speed = 0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2 - circleLayer.lineWidth / 2
        let startAngle = CGFloat(-M_PI_2)
        let endAngle = CGFloat(M_PI_2 * 3)
        let path = UIBezierPath(arcCenter: CGPointZero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)        
        
        circleLayer.position = center
        circleLayer.path = path.CGPath
    }
    
}



