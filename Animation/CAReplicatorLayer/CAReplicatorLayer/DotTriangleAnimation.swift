//
//  DotTriangleAnimation.swift
//  CAReplicatorLayer
//
//  Created by FanYu on 29/2/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

struct DotTriangleAnimation: ActivityIndicatorViewProtocol {
    
    func setupAnimationInLayer(layer: CALayer, size: CGFloat, tintColor: UIColor) {
        
        let dotSize = size / 4
        let transformX: CGFloat = size - dotSize
        
        let dot = CAShapeLayer()
        dot.frame = CGRect(x: 0, y: 0, width: dotSize, height: dotSize)
        dot.path = UIBezierPath(ovalInRect: CGRect(x: 0, y: 0, width: dotSize, height: dotSize)).CGPath
        dot.lineWidth = 1
        dot.strokeColor = tintColor.CGColor
        dot.fillColor = UIColor.clearColor().CGColor
        
        dot.addAnimation(rotationAnimation(transformX), forKey: "rotation")
        
        // transform is used to put the dot in right place 相当于复制规则
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, transformX, 0, 0)
        transform =  CATransform3DRotate(transform, toAngle(120), 0, 0, 1)
        
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame = CGRect(x: 0, y: 0, width: dotSize, height: dotSize)
        replicatorLayer.instanceDelay = 0.0
        replicatorLayer.instanceCount = 3
        replicatorLayer.instanceTransform = transform
        replicatorLayer.addSublayer(dot)
        
        layer.addSublayer(replicatorLayer)
    }
    
    private func rotationAnimation(transformX: CGFloat) -> CABasicAnimation {
        let rotateAnim = CABasicAnimation(keyPath: "transform")
        
        let t = CATransform3DIdentity
        
        let tFrom = CATransform3DRotate(t, 0, 0, 0, 0)
        
        // 移动 X 距离 然后再旋转 120 度
        var tTo = CATransform3DTranslate(t, transformX, 0, 0)
        tTo = CATransform3DRotate(tTo, toAngle(120), 0, 0, 1)
        
        rotateAnim.fromValue = NSValue.init(CATransform3D: tFrom)
        rotateAnim.toValue = NSValue.init(CATransform3D: tTo)
        rotateAnim.autoreverses = false
        rotateAnim.repeatCount = HUGE
        rotateAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        rotateAnim.duration = 0.8
        
        return rotateAnim
    }
    
    private func toAngle(degree: CGFloat) -> CGFloat {
        return degree * CGFloat(M_PI) / CGFloat(180)
    }
}
