//
//  CountDownButton.swift
//  CountDown
//
//  Created by FanYu on 2/2/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

enum AnimationType {
    case ScaleAnimation
    case RotateAnimation
    case ShakeAnimation
    case YRotateAnimation
}

class CountDownButton: UIButton {

    // color
    private var defaultNormalColor = UIColor(red:0.02, green:0.6, blue:0.99, alpha:1)
    private var defaultCountColor = UIColor(red:0.95, green:0.25, blue:0.51, alpha:1)
    
    // counter
    private var timer: NSTimer!
    private var startCount = 0
    private var originNum = 0
    private var countLabel = UILabel()
    
    // animation type
    var animationType = AnimationType.RotateAnimation
    
    // init
    convenience init(count: Int, frame: CGRect, animationType: AnimationType, var normalColor: UIColor?, var countColor: UIColor?) {
        self.init(frame: frame)
 
        // count
        self.originNum = count
        self.startCount = count
        
        // animation type 
        self.animationType = animationType
        
        // normal color
        if normalColor == nil {
            normalColor = defaultNormalColor
        } else {
            defaultNormalColor = normalColor!
        }
        
        // count color
        if countColor == nil {
            countColor = defaultCountColor
        } else {
            defaultCountColor = countColor!
        }
        
        // self action
        self.backgroundColor = normalColor
        self.addTarget(self, action: "startCountDown", forControlEvents: .TouchUpInside)
        
        // count label 
        countLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))
        countLabel.textColor = UIColor.whiteColor()
        countLabel.backgroundColor = UIColor.clearColor()
        countLabel.textAlignment = .Center
        countLabel.font = UIFont.systemFontOfSize(20)
        countLabel.text = "\(self.originNum)"
        self.addSubview(countLabel)
    }
}


// MARK: - Action Handler 
// 
extension CountDownButton {
    func startCountDown() {
        // timer
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("countDown"), userInfo: nil, repeats: true)
        
        // self button
        self.backgroundColor = defaultCountColor
        self.enabled = false
        
        switch self.animationType {
        case .RotateAnimation  : self.rotateAnimation()
        case .ScaleAnimation   : self.scaleAnimation()
        case .ShakeAnimation   : self.shakeAnimation()
        case .YRotateAnimation : self.yRotateAnimation()
        }
    }
    
    func countDown() {
        self.startCount--
        countLabel.text = "\(self.startCount)"
        
        // if count down finished
        if self.startCount < 0 {
            guard self.timer != nil else {
                return
            }
            
            self.countLabel.layer.removeAllAnimations()
            self.countLabel.text = "\(self.originNum)"
            self.timer.invalidate()
            self.timer = nil
            self.enabled = true
            self.startCount = self.originNum
            self.backgroundColor = defaultNormalColor
        }
    }
}

// MARK: - Animation
//
extension CountDownButton {
    
    func scaleAnimation() {
        // scale animation
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnimation.keyTimes = [0, 0.5, 1]
        scaleAnimation.values = [1, 1.5, 2]
        
        
        // opacity animation
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.keyTimes = [0, 0.5, 1]
        opacityAnimation.values = [1, 0.5, 0]
        
        // group
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [scaleAnimation, opacityAnimation]
        groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        groupAnimation.duration = 1
        groupAnimation.repeatCount = HUGE
        groupAnimation.removedOnCompletion = false
        groupAnimation.beginTime = CACurrentMediaTime()
        
        self.countLabel.layer.addAnimation(groupAnimation, forKey: "Scale")
    }
    
    // rotate animation
    func rotateAnimation() {
        
        let duration: CFTimeInterval = 1
        
        // Rotate animation
        let rotateAnimation  = CABasicAnimation(keyPath: "transform.rotation.z")
        rotateAnimation.fromValue = NSNumber(int: 0)
        rotateAnimation.toValue = NSNumber(double: M_PI * 2)
        
        // Opacity animation
        let opacityAnimaton = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimaton.keyTimes = [0, 0.5]
        opacityAnimaton.values = [1, 0]
        opacityAnimaton.duration = duration
        
        // Scale animation
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnimation.keyTimes = [0, 0.5]
        scaleAnimation.values = [2, 0]
        
        // group
        let animation = CAAnimationGroup()
        animation.animations = [rotateAnimation, opacityAnimaton, scaleAnimation]
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.removedOnCompletion = false
        animation.beginTime = CACurrentMediaTime()
        countLabel.layer.addAnimation(animation, forKey: "animation")
        
        
    }
    
    func shakeAnimation() {
        let shakeAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        shakeAnimation.duration = 0.3
        shakeAnimation.fromValue = NSNumber(int: -5)
        shakeAnimation.toValue = NSNumber(int: 5)
        shakeAnimation.repeatCount = HUGE
        shakeAnimation.autoreverses = true
        shakeAnimation.beginTime = CACurrentMediaTime()
        countLabel.layer.addAnimation(shakeAnimation, forKey: nil)
    }
    
    func yRotateAnimation() {
        // rotate
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation.x")
        rotateAnimation.fromValue = 0
        rotateAnimation.toValue = M_PI
        rotateAnimation.duration = 1
        rotateAnimation.repeatCount = HUGE
        rotateAnimation.removedOnCompletion = false
        
        let opacityAnimaton = CABasicAnimation(keyPath: "opacity")
        opacityAnimaton.fromValue = 1
        opacityAnimaton.toValue = 0
        
        // group
        let animation = CAAnimationGroup()
        animation.animations = [rotateAnimation, opacityAnimaton]
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 1
        animation.repeatCount = HUGE
        animation.removedOnCompletion = false
        animation.beginTime = CACurrentMediaTime()
        countLabel.layer.addAnimation(animation, forKey: "animation")
    }
}
