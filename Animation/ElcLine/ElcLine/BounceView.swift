//
//  BounceView.swift
//  ElcLine
//
//  Created by FanYu on 18/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class BounceView: UIView {

    // shapeLayer
    let lineLayer = CAShapeLayer()
    
    // circle view 
    let leftCircle = UIView()
    let rightCircle = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        
        // gesture 
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "handlePan:"))
        
        // line shape layer
        lineLayer.strokeColor = UIColor.whiteColor().CGColor
        lineLayer.fillColor = UIColor.whiteColor().CGColor
        lineLayer.lineWidth = 1
        self.layer.addSublayer(lineLayer)
        
        // self
        backgroundColor = UIColor.orangeColor()
        
        // circle
        leftCircle.frame = CGRect(x: -100, y: 0, width: 100, height: 100)
        leftCircle.backgroundColor = UIColor.redColor()
        leftCircle.layer.cornerRadius = 50
        self.addSubview(leftCircle)
        
        rightCircle.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        rightCircle.backgroundColor = UIColor.blueColor()
        rightCircle.layer.cornerRadius = 50
        self.addSubview(rightCircle)
    }
    
    override func layoutSubviews() {
        leftCircle.center = CGPoint(x: -100, y: self.bounds.size.height / 2)
        rightCircle.center = CGPoint(x: self.bounds.size.width + 100, y: self.bounds.size.height / 2)
        
    }
    
    func handlePan(pan: UIPanGestureRecognizer) {
        let deltaX = pan.translationInView(self).x
        
        if pan.state == .Changed {
            // slide right
            if deltaX > 0 {
                lineLayer.path = leftLinePathWithAmount(deltaX)
                leftCircle.frame = CGRect(x: -100 + deltaX * 0.4, y: leftCircle.frame.origin.y, width: 100, height: 100)
                
            } else {
                lineLayer.path = rightLinePathWithAmount(deltaX)
                rightCircle.frame = CGRect(x: self.bounds.size.width + deltaX * 0.4, y: rightCircle.frame.origin.y, width: 100, height: 100)
            }
        } else if pan.state == .Cancelled || pan.state == .Ended || pan.state == .Failed {
            resetLeftCircle()
            resetRightCircle()
            resetLeftLine(deltaX)
        }
    }
    
    func resetLeftCircle() {
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.leftCircle.center = CGPoint(x: -100, y: self.bounds.size.height / 2)
            }, completion: { (Bool) -> Void in
        })
    }
    
    func resetRightCircle() {
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.rightCircle.center = CGPoint(x: self.bounds.size.width + 100, y: self.bounds.size.height / 2)
            }, completion: { (Bool) -> Void in
                
        })
    }
    
    func resetLeftLine(value: CGFloat) {
        let animation = CAKeyframeAnimation(keyPath: "path")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        animation.values = [leftLinePathWithAmount(value),
            leftLinePathWithAmount(-value * 0.9),
            leftLinePathWithAmount(value * 0.6),
            leftLinePathWithAmount(-value * 0.4),
            leftLinePathWithAmount(value * 0.25),
            leftLinePathWithAmount(-value * 0.15),
            leftLinePathWithAmount(value * 0.05),
            leftLinePathWithAmount(0)
        ]
        animation.duration = 0.5
        animation.removedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.delegate = self
        self.lineLayer.addAnimation(animation, forKey: "left")
    }
    
    func leftLinePathWithAmount(amount: CGFloat) ->CGPathRef {
        let verticalPath = UIBezierPath()
        let topPoint = CGPoint(x: 0, y: 0)
        let midControlPoint = CGPoint(x: amount, y: self.bounds.size.height / 2)
        let bottomPoint = CGPoint(x: 0, y: self.bounds.size.height)
        
        verticalPath.moveToPoint(topPoint)
        verticalPath.addQuadCurveToPoint(bottomPoint, controlPoint: midControlPoint)
        verticalPath.closePath()
        
        return verticalPath.CGPath
    }
    
    func rightLinePathWithAmount(amount: CGFloat) ->CGPathRef {
        let verticalPath = UIBezierPath()
        let topPoint = CGPoint(x: self.bounds.size.width, y: 0)
        let midControlPoint = CGPoint(x: self.bounds.size.width + amount, y: self.bounds.size.height / 2)
        let bottomPoint = CGPoint(x: self.bounds.size.width, y: self.bounds.size.height)
        
        verticalPath.moveToPoint(topPoint)
        verticalPath.addQuadCurveToPoint(bottomPoint, controlPoint: midControlPoint)
        verticalPath.closePath()
        
        return verticalPath.CGPath
    }
    
}
