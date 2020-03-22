//
//  RadarView.swift
//  RadarView
//
//  Created by FanYu on 30/10/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class RadarView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        // 设置颜色 并且填充
        //UIColor(red:0.397, green:0.795, blue:0.992, alpha:1).setFill()//
        UIColor.whiteColor().setFill()
        UIRectFill(rect)
        
        let radarNum = 7
        let animationDuration: Double = 4
        let animationLayer = CALayer()
        
        var randomColor: UIColor?
        
        for i in 0 ... radarNum {
            
            randomColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1)
            
            let pulseLayer = CALayer()
            pulseLayer.frame = CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height)
            pulseLayer.borderColor = randomColor?.CGColor//UIColor.blueColor().CGColor
            pulseLayer.borderWidth = 5
            pulseLayer.cornerRadius = rect.size.width / 2
            
            // 缩放动画 0 到 1.5 倍
            let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
            scaleAnimation.fromValue = Double(0.2)
            scaleAnimation.toValue = Double(1.5)
            
            // 透明度动画
            let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
            opacityAnimation.values = [Double(1),Double(0.7), Double(0)]
            opacityAnimation.keyTimes = [Double(0),Double(0.5), Double(1)]
            
            // 发生动画的时间节奏
            let timingCurve = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
            
            // 有两个动画，所以定义一个Group
            let animationGroup = CAAnimationGroup()
            animationGroup.fillMode = kCAFillModeBoth // 动画结束后,保持最初状态 即为最小
            animationGroup.beginTime = CACurrentMediaTime() + Double(i) * animationDuration / Double(radarNum) // Duration内执行完Num个雷达
            animationGroup.duration = animationDuration
            animationGroup.repeatCount = HUGE
            animationGroup.timingFunction = timingCurve // pacing of animation
            animationGroup.autoreverses = true
            //animationGroup.speed = 2
            //animationGroup.timeOffset = 2
            
            animationGroup.animations = [scaleAnimation, opacityAnimation]
            
            
            // 动画加入到 pulseLayer
            pulseLayer.addAnimation(animationGroup, forKey: "Pluse")
            
            // pulseLayer 加到 animationLayer
            animationLayer.addSublayer(pulseLayer)
        }
        
        // animationLayer 加到 layer
        self.layer.addSublayer(animationLayer)
    }
}
