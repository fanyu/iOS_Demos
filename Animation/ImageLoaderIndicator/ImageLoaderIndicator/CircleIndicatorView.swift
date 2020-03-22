//
//  CircleIndicatorView.swift
//  CircleIndicatorForLoadingImage
//
//  Created by FanYu on 4/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class CircleIndicatorView: UIView {

    let circleShapeLayer = CAShapeLayer()
    let circleRadius: CGFloat = 20
    
    var progress: CGFloat { // computed property
        get {
            return circleShapeLayer.strokeEnd
        }
        
        set {
            if newValue > 1 {
                circleShapeLayer.strokeEnd = 1
            } else if newValue < 0 {
                circleShapeLayer.strokeEnd = 0
            } else {
                circleShapeLayer.strokeEnd = newValue
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // 如果设置frame与本view一样，必须在这里设置，因为在init时候，本view还没有大小 为(0,0,0,0)
    override func layoutSubviews() {
        super.layoutSubviews()
        
        circleShapeLayer.frame = bounds
        circleShapeLayer.path = circlePath().CGPath
    }
    
    func setup() {
        circleShapeLayer.lineWidth = 3
        circleShapeLayer.strokeColor = UIColor.redColor().CGColor
        circleShapeLayer.fillColor = UIColor.clearColor().CGColor
        circleShapeLayer.strokeEnd = 0
        layer.addSublayer(circleShapeLayer)
        
        backgroundColor = UIColor.whiteColor()
    }
    
    func circleFrame() ->CGRect {
        var circleRect = CGRect(x: 0, y: 0, width: 2 * circleRadius, height: 2 * circleRadius)
        circleRect.origin.x = CGRectGetMidX(circleShapeLayer.bounds) - CGRectGetMidX(circleRect)
        circleRect.origin.y = CGRectGetMidY(circleShapeLayer.bounds) - CGRectGetMidY(circleRect)
        return circleRect
    }
    
    func circlePath() ->UIBezierPath {
        return UIBezierPath(ovalInRect: circleFrame())
    }
    
    func reveal() {
        // show image
        backgroundColor = UIColor.clearColor()
        progress = 1
        
        // remove implicit animations
        circleShapeLayer.removeAnimationForKey("strokeEnd")
        
        // reuse the circleshapelayer to mask super view
        circleShapeLayer.removeFromSuperlayer()
        superview?.layer.mask = circleShapeLayer
        
        // to value
        let center = CGPoint(x: CGRectGetMidX(bounds), y: CGRectGetMidY(bounds))
        let finalRadius = sqrt((center.x * center.x) + (center.y * center.y))
        let radiusInset = finalRadius - circleRadius
        let outerRect = CGRectInset(circleFrame(), -radiusInset, -radiusInset)
        let toPath = UIBezierPath(ovalInRect: outerRect).CGPath
        
        // from value
        let fromPath = circleShapeLayer.path
        let fromLineWidth = circleShapeLayer.lineWidth
        
        // transaction 设置最终数值，防止完成动画时 跳回原始状态，其实没什么影响 😂😂😂
//        CATransaction.begin()
//        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
//        circleShapeLayer.lineWidth = 2 * finalRadius
//        circleShapeLayer.path = toPath
//        CATransaction.commit()
        
        // animation  圆环改变半径和线宽，可以变为圆形
        let lineWidthAnimation = CABasicAnimation(keyPath: "lineWidth")
        lineWidthAnimation.fromValue = fromLineWidth
        lineWidthAnimation.toValue = 2 * finalRadius
        //lineWidthAnimation.duration = 3
        
        let pathAnimaiton = CABasicAnimation(keyPath: "path")
        pathAnimaiton.fromValue = fromPath
        pathAnimaiton.toValue = toPath
        //pathAnimaiton.duration = 3
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = 1
        groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        groupAnimation.animations = [lineWidthAnimation, pathAnimaiton]
        groupAnimation.delegate = self
        
        circleShapeLayer.addAnimation(groupAnimation, forKey: "strokeWidth")
        //circleShapeLayer.addAnimation(lineWidthAnimation, forKey: "strokeWidth")
        //circleShapeLayer.addAnimation(pathAnimaiton, forKey: "strokeWidth")

    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        superview?.layer.mask = nil
    }
    
    
}
