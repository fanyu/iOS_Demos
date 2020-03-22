//
//  BookPagingView.swift
//  TransitionDemo
//
//  Created by FanYu on 5/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class BookPagingView: UIView {
    
    let container = UIView()
    let redView = UIView()
    let orangeView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        container.backgroundColor = UIColor.whiteColor()
        redView.backgroundColor = UIColor.redColor()
        orangeView.backgroundColor = UIColor.orangeColor()
        
        container.addSubview(orangeView)
        container.addSubview(redView)
        
        self.backgroundColor = UIColor.blackColor()
        addSubview(container)
    }
    
    override func layoutSubviews() {
        container.frame = bounds
        redView.frame = bounds
        orangeView.frame = bounds
    }
    
    func performCurl() {
        var views = (frontView: redView, backView: orangeView)
        
        if (self.redView.superview != nil) {
            views = (frontView: self.redView, backView: self.orangeView)
        } else {
            views = (frontView: self.orangeView, backView: self.redView)
        }
        
        // transition
        let transition = UIViewAnimationOptions.TransitionCurlDown
 
        UIView.transitionFromView(views.frontView, toView: views.backView, duration: 1, options: transition) { (Bool) -> Void in
        }
    }
    
    
    func performRotation() {
        let rotation = CGFloat(M_PI * 2)
        let transition = UIViewKeyframeAnimationOptions.CalculationModeLinear
        
        UIView.animateKeyframesWithDuration(2, delay: 0, options: transition, animations: { () -> Void in
            
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 1/3, animations: { () -> Void in
                self.container.transform = CGAffineTransformMakeRotation(rotation * 1 / 3)
            })
            UIView.addKeyframeWithRelativeStartTime(1/3, relativeDuration: 1/3, animations: { () -> Void in
                self.container.transform = CGAffineTransformMakeRotation(rotation * 2 / 3)
            })
            UIView.addKeyframeWithRelativeStartTime(2/3, relativeDuration: 1/3, animations: { () -> Void in
                self.container.transform = CGAffineTransformMakeRotation(rotation * 3 / 3)
            })
            
            }) { (Bool) -> Void in
        }
    }
    
    func performAlongBezier() {
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0, y: 239))
        path.addCurveToPoint(CGPoint(x: 301, y: 239), controlPoint1: CGPoint(x: 136, y: 317), controlPoint2: CGPoint(x: 178, y: 110))
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.rotationMode = kCAAnimationRotateAuto
        animation.repeatCount = HUGE
        animation.duration = 4
        animation.path = path.CGPath
        
        redView.layer.addAnimation(animation, forKey: "move Alone")
    }
}
