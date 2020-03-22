//
//  EDCCircleLayer.swift
//  CircleRefresh
//
//  Created by FanYu on 5/1/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

// 可以转动多圈，不像strokeEnd 只有0 － 1 
class EDCCircleRealTimeDraw: CALayer {
    
    var progress: CGFloat = 1
    
    private let lineWidth: CGFloat = 8
    
    // 用来触发drawInContext 进行实时绘制, key先从自定义的变量开始查找，然后才是系统变量，我们不用在其他地方调用这个函数，只要我们对设置了返回true的变量 发生了改变，则会自动触发执行drawInRect
    override class func needsDisplayForKey(key: String) -> Bool {
        //print("\(NSDate()) \t needs  \t \(key)")

        if key == "progress" {
            //print("\(NSDate()) \t PPPPP \t \(key)")
            return true
        }
        return super.needsDisplayForKey(key)
    }
    
    // 绘制CALayer的内容 所以用绘制 CGContext 而不是 ShapeLayer 且自己是不会触发的 
    override func drawInContext(ctx: CGContext) {
        //print("\(NSDate()) draw")
        
        // path
        let path = UIBezierPath()
        let center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))
        let raidus: CGFloat = CGRectGetHeight(self.bounds) / 2 - lineWidth / 2
        // Origin
        let originStart = CGFloat(M_PI * 7 / 2)
        let originEnd = CGFloat(M_PI * 2)
        let currentOrigin: CGFloat = originStart - (originStart - originEnd) * progress
        // Destination
        let destStart = CGFloat(M_PI * 3)
        let destEnd: CGFloat = 0
        let currentDest: CGFloat = destStart - (destStart - destEnd) * progress
        path.addArcWithCenter(center, radius: raidus, startAngle: currentOrigin, endAngle: currentDest, clockwise: false)
        
        // context
        CGContextAddPath(ctx, path.CGPath)
        CGContextSetLineWidth(ctx, lineWidth)
        CGContextSetStrokeColorWithColor(ctx, UIColor.redColor().CGColor)
        CGContextStrokePath(ctx)
    }
    
}
