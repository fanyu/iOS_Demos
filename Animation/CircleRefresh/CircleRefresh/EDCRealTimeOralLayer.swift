//
//  EDCRealTimeOralLayer.swift
//  CircleRefresh
//
//  Created by FanYu on 7/1/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

class EDCRealTimeOralLayer: CALayer {

    var progress: CGFloat = 0
    
    private let lineWidth: CGFloat = 6
    private let radius: CGFloat = 80
    private let xScale: CGFloat = 0.8
    private let yScale: CGFloat = 0.8
    private let controlPointFactor: CGFloat = 1.8
    private let pointRadius: CGFloat = 3.0
    
    override class func needsDisplayForKey(key: String) -> Bool {
        if key == "progress" {
            return true
        }
        return super.needsDisplayForKey(key)
    }

    override func drawInContext(ctx: CGContext) {
        let path = UIBezierPath()
        let center = CGPoint(x: CGRectGetMidX(bounds), y: CGRectGetMidY(bounds))
        let xOffset = radius * 2 * (1 - xScale) / 2 * progress
        let yOffset = radius * 2 * (1 - yScale) / 2 * progress
        let controlOffset = radius / controlPointFactor
        
        // right up arc 
        let origin1 = CGPointMake(center.x + radius + xOffset, center.y + yOffset)
        let dest1 = CGPointMake(center.x, center.y - radius + yOffset * 3)
        let control1A = CGPointMake(origin1.x, origin1.y - controlOffset)
        let control1B = CGPointMake(dest1.x + controlOffset, center.y - radius + yOffset * 2)
        path.moveToPoint(origin1)
        path.addCurveToPoint(dest1, controlPoint1: control1A, controlPoint2: control1B)

        // 左上弧
        let origin2 = dest1
        let dest2 = CGPointMake(center.x - radius - xOffset, center.y + yOffset)
        let control2A = CGPointMake(origin2.x - controlOffset, center.y - radius + yOffset * 2)
        let control2B = CGPointMake(dest2.x, dest2.y - controlOffset)
        path.addCurveToPoint(dest2, controlPoint1: control2A, controlPoint2: control2B)
        
        // 左下弧
        let origin3 = dest2
        let dest3 = CGPointMake(center.x, center.y + radius)
        let control3A = CGPointMake(origin3.x, origin3.y + controlOffset)
        let control3B = CGPointMake(dest3.x - controlOffset, dest3.y)
        path.addCurveToPoint(dest3, controlPoint1: control3A, controlPoint2: control3B)
        
        // 右下弧
        let origin4 = dest3
        let dest4 = origin1
        let control4A = CGPointMake(origin4.x + controlOffset, origin4.y)
        let control4B = CGPointMake(dest4.x, dest4.y + controlOffset)
        path.addCurveToPoint(dest4, controlPoint1: control4A, controlPoint2: control4B)
        
        CGContextAddPath(ctx, path.CGPath)
        CGContextSetLineWidth(ctx, lineWidth)
        CGContextSetStrokeColorWithColor(ctx, UIColor.blueColor().CGColor)
        CGContextStrokePath(ctx)
        
        // 辅助点
        let pointsPath = UIBezierPath()
        
        addArcForPath(pointsPath, point: origin1)
        addArcForPath(pointsPath, point: control1A)
        addArcForPath(pointsPath, point: control1B)
        addArcForPath(pointsPath, point: dest1)
        
        addArcForPath(pointsPath, point: origin2)
        addArcForPath(pointsPath, point: control2A)
        addArcForPath(pointsPath, point: control2B)
        addArcForPath(pointsPath, point: dest2)
        
        addArcForPath(pointsPath, point: origin3)
        addArcForPath(pointsPath, point: control3A)
        addArcForPath(pointsPath, point: control3B)
        addArcForPath(pointsPath, point: dest3)
        
        addArcForPath(pointsPath, point: origin4)
        addArcForPath(pointsPath, point: control4A)
        addArcForPath(pointsPath, point: control4B)
        addArcForPath(pointsPath, point: dest4)
        
        CGContextAddPath(ctx, pointsPath.CGPath)
        
        CGContextSetFillColorWithColor(ctx, UIColor.redColor().CGColor)
        CGContextFillPath(ctx)
        
        // 辅助线
        let linePath = UIBezierPath()
        
        linePath.moveToPoint(origin1)
        linePath.addLineToPoint(control1A)
        linePath.addLineToPoint(control1B)
        linePath.addLineToPoint(dest1)
        
        linePath.addLineToPoint(origin2)
        linePath.addLineToPoint(control2A)
        linePath.addLineToPoint(control2B)
        linePath.addLineToPoint(dest2)
        
        linePath.addLineToPoint(origin3)
        linePath.addLineToPoint(control3A)
        linePath.addLineToPoint(control3B)
        linePath.addLineToPoint(dest3)
        
        linePath.addLineToPoint(origin4)
        linePath.addLineToPoint(control4A)
        linePath.addLineToPoint(control4B)
        linePath.addLineToPoint(dest4)
        
        CGContextAddPath(ctx, linePath.CGPath)
        CGContextSetLineWidth(ctx, 2)
        CGContextSetStrokeColorWithColor(ctx, UIColor.redColor().CGColor)
        CGContextStrokePath(ctx)

    }
    
    // MARK: - tools
    private func addArcForPath(path: UIBezierPath, point: CGPoint) {
        path.moveToPoint(point)
        path.addArcWithCenter(point, radius: pointRadius, startAngle: 0, endAngle: CGFloat(M_PI * 2.0), clockwise: true)
    }
}
