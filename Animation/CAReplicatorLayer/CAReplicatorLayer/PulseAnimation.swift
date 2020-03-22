//
//  PulseAnimation.swift
//  CAReplicatorLayer
//
//  Created by FanYu on 26/2/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

struct PulseAnimation: ActivityIndicatorViewProtocol {
    
    func setupAnimationInLayer(layer: CALayer, size: CGFloat, tintColor: UIColor) {
    
        let pulse = CAShapeLayer()
        pulse.frame = CGRect(x: 0, y: 0, width: size, height: size)
        pulse.path = UIBezierPath(ovalInRect: CGRect(x: 0, y: 0, width: size, height: size)).CGPath
        pulse.fillColor = tintColor.CGColor
        // hide the original layer 
        pulse.opacity = 0.0
        
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame = CGRect(x: 0, y: 0, width: size, height: size)
        replicatorLayer.instanceDelay = 0.5
        replicatorLayer.instanceCount = 8
        replicatorLayer.addSublayer(pulse)
        
        layer.addSublayer(replicatorLayer)
        
        pulse.addAnimation(groupAnimation(), forKey: "scale and opacity")
    }
    
    private func groupAnimation() -> CAAnimationGroup {
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [alphaAnimation(), scaleAnimation()]
        groupAnimation.duration = 4.0
        groupAnimation.autoreverses = false
        groupAnimation.repeatCount = HUGE
        
        return groupAnimation
    }
    
    private func alphaAnimation() -> CABasicAnimation {
        let alphaAnim = CABasicAnimation(keyPath: "opacity")
        alphaAnim.fromValue = 1.0
        alphaAnim.toValue = 0
        
        return alphaAnim
    }
    
    private func scaleAnimation() -> CABasicAnimation {
        let scaleAnim = CABasicAnimation(keyPath: "transform")
        
        let t = CATransform3DIdentity
        let tFrom = CATransform3DScale(t, 0, 0, 0)
        let tTo = CATransform3DScale(t, 1, 1, 0)
        
        scaleAnim.fromValue = NSValue.init(CATransform3D: tFrom)
        scaleAnim.toValue = NSValue.init(CATransform3D: tTo)
        
        return scaleAnim
    }
}