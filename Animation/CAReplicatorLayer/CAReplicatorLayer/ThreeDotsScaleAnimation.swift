//
//  ThreeDotsScaleAnimation.swift
//  CAReplicatorLayer
//
//  Created by FanYu on 29/2/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

struct ThreeDotsScaleAnimation: ActivityIndicatorViewProtocol {
    
    func setupAnimationInLayer(layer: CALayer, size: CGFloat, tintColor: UIColor) {
        let marginBetweenDot: CGFloat = 5.0
        let dotSize = (size - 2 * marginBetweenDot) / 3
        
        let dot = CAShapeLayer()
        dot.frame = CGRect(x: 0, y: (size - dotSize) / 2, width: dotSize, height: dotSize)
        dot.path = UIBezierPath(ovalInRect: CGRect(x: 0, y: 0, width: dotSize, height: dotSize)).CGPath
        dot.fillColor = tintColor.CGColor
        
        dot.addAnimation(scaleAnimation(), forKey: "scale")
        
        // transform is used to move the dot to right place
        let transform = CATransform3DMakeTranslation(marginBetweenDot + dotSize, 0, 0)
        
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame = CGRect(x: 0, y: 0, width: size, height: size)
        replicatorLayer.instanceDelay = 0.2
        replicatorLayer.instanceCount = 3
        replicatorLayer.instanceTransform = transform
        replicatorLayer.addSublayer(dot)
        
        layer.addSublayer(replicatorLayer)
    }
    
    private func scaleAnimation() -> CABasicAnimation {
        let scaleAnim = CABasicAnimation(keyPath: "transform")
        
        let t = CATransform3DIdentity
        let tFrom = CATransform3DScale(t, 1.0, 1.0, 0)
        let tTo = CATransform3DScale(t, 0.2, 0.2, 0)
        
        scaleAnim.fromValue = NSValue.init(CATransform3D: tFrom)
        scaleAnim.toValue = NSValue.init(CATransform3D: tTo)
        scaleAnim.autoreverses = true
        scaleAnim.repeatCount = HUGE
        scaleAnim.duration = 0.3
        
        return scaleAnim
    }
}