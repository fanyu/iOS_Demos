//
//  CircleView.swift
//  RotateCircle
//
//  Created by FanYu on 16/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class CircleView: UIView {
    
    private let shaperLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        self.backgroundColor = UIColor.whiteColor()
        
        shaperLayer.lineWidth = 2
        shaperLayer.strokeColor = UIColor.redColor().CGColor
        shaperLayer.fillColor = UIColor.clearColor().CGColor
        shaperLayer.strokeStart = 0
        shaperLayer.strokeEnd = 0.9
        
        layer.addSublayer(shaperLayer)
    }
    
    override func layoutSubviews() {
        let inset = shaperLayer.lineWidth / 2.0
        shaperLayer.frame = self.bounds
        shaperLayer.path = UIBezierPath(ovalInRect: CGRectInset(shaperLayer.bounds, inset, inset)).CGPath
    }
    
    func startRotating() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = toRadius(360)
        rotationAnimation.duration = 2
        rotationAnimation.fillMode = kCAFillModeForwards
        rotationAnimation.removedOnCompletion = false
        rotationAnimation.repeatCount = HUGE
        rotationAnimation.autoreverses = false
        shaperLayer.addAnimation(rotationAnimation, forKey: "rotation")
    }
    
    func manualRotate() {
        let rotationAnimation = CABasicAnimation(keyPath: "stokeEnd")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = 0.9
        rotationAnimation.autoreverses = false
        shaperLayer.addAnimation(rotationAnimation, forKey: "stroke end")
    }
    
    func toRadius(degree: CGFloat) ->CGFloat {
        return degree * CGFloat(M_PI) / 180
    }
}