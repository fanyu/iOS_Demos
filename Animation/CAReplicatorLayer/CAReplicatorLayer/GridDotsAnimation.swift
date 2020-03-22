//
//  GridDotsAnimation.swift
//  CAReplicatorLayer
//
//  Created by FanYu on 29/2/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

struct GridDotsAnimation: ActivityIndicatorViewProtocol {
    
    func setupAnimationInLayer(layer: CALayer, size: CGFloat, tintColor: UIColor) {
        
        // var
        let nbColumn = 3
        let marginBetweenDot: CGFloat = 5.0
        let dotSize = (size - (marginBetweenDot * (CGFloat(nbColumn)  - 1))) / CGFloat(nbColumn)
        
        // dot shape layer
        let dot = CAShapeLayer()
        dot.frame = CGRect(x: 0, y: 0, width: dotSize, height: dotSize)
        dot.path = UIBezierPath(ovalInRect: CGRect(x: 0, y: 0, width: dotSize, height: dotSize)).CGPath
        dot.fillColor = tintColor.CGColor
        
        // add anim to dot
        dot.addAnimation(groupAnimation(), forKey: "scale and alpha")
        
        // replicator X
        var transformX = CATransform3DIdentity
        transformX = CATransform3DTranslate(transformX, dotSize + marginBetweenDot, 0, 0)
        
        let replicatorLayerX = CAReplicatorLayer()
        replicatorLayerX.frame = CGRect(x: 0, y: 0, width: size, height: size)
        replicatorLayerX.instanceDelay = 0.3
        replicatorLayerX.instanceCount = nbColumn
        replicatorLayerX.instanceTransform = transformX
        
        // replicator Y
        var transformY = CATransform3DIdentity
        transformY = CATransform3DTranslate(transformY, 0, dotSize + marginBetweenDot, 0)
        
        let replicatorLayerY = CAReplicatorLayer()
        replicatorLayerY.frame = CGRect(x: 0, y: 0, width: size, height: size)
        replicatorLayerY.instanceDelay = 0.3
        replicatorLayerY.instanceCount = nbColumn
        replicatorLayerY.instanceTransform = transformY
        
        // sublayers
        replicatorLayerX.addSublayer(dot)
        replicatorLayerY.addSublayer(replicatorLayerX)
        layer.addSublayer(replicatorLayerY)
    }
    
    private func groupAnimation() -> CAAnimationGroup {
        let groupAnim = CAAnimationGroup()
        groupAnim.animations = [alphaAnimation(), scaleAnimation()]
        groupAnim.duration = 1.0
        groupAnim.autoreverses = true
        groupAnim.repeatCount = HUGE
        
        return groupAnim
    }
    
    private func alphaAnimation() -> CABasicAnimation {
        let alphaAnim = CABasicAnimation(keyPath: "opacity")
        alphaAnim.fromValue = 1.0
        alphaAnim.toValue = 0.3
        
        return alphaAnim
    }
    
    private func scaleAnimation() -> CABasicAnimation {
        let scaleAnim = CABasicAnimation(keyPath: "transform")
        
        let t = CATransform3DIdentity
        let tFrom = CATransform3DScale(t, 1, 1, 0)
        let tTo = CATransform3DScale(t, 0.2, 0.2, 0)
        
        scaleAnim.fromValue = NSValue.init(CATransform3D: tFrom)
        scaleAnim.toValue = NSValue.init(CATransform3D: tTo)
        
        return scaleAnim
    }
}
