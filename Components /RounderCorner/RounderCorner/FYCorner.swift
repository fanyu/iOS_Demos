//
//  FYCorner.swift
//  RounderCorner
//
//  Created by FanYu on 1/3/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit


private func pixel(num: Double) -> Double {
    var unit: Double
    switch Int(UIScreen.mainScreen().scale) {
    case 1: unit = 1.0 / 1.0
    case 2: unit = 1.0 / 2.0
    case 3: unit = 1.0 / 3.0
    default: unit = 0.0
    }
    return roundbyunit(num, &unit)
}

private func roundbyunit(num: Double, inout _ unit: Double) -> Double {
    let remain = modf(num, &unit)
    if (remain > unit / 2.0) {
        return ceilbyunit(num, &unit)
    } else {
        return floorbyunit(num, &unit)
    }
}

private func ceilbyunit(num: Double, inout _ unit: Double) -> Double {
    return num - modf(num, &unit) + unit
}

private func floorbyunit(num: Double, inout _ unit: Double) -> Double {
    return num - modf(num, &unit)
}


// MARK: - UIView 
//
extension UIView {
    
    func FYAddCorner(radius radius: CGFloat) {
        self.FYAddCorner(radius: radius, borderWidth: 1, borderColor: UIColor.clearColor(), backgroundColor: UIColor.blackColor())
    }
    
    func FYAddCorner(radius radius: CGFloat, borderWidth: CGFloat, borderColor: UIColor, backgroundColor: UIColor) {
        
        let imageView = UIImageView(image: FYDrawRectWithRoundedCorner(radius: radius, borderWidth: borderWidth, backgroundColor: backgroundColor, borderColor: borderColor))
        self.insertSubview(imageView, atIndex: 0)
    }
    
    func FYDrawRectWithRoundedCorner(radius radius: CGFloat, borderWidth: CGFloat, backgroundColor: UIColor, borderColor: UIColor) -> UIImage {
        
        let sizeToFit = CGSize(width: pixel(Double(self.bounds.size.width)), height: Double(self.bounds.size.height))
        let scale = UIScreen.mainScreen().scale
        let halfBorderWidth = CGFloat(borderWidth / 2)
        
        // begin draw
        UIGraphicsBeginImageContextWithOptions(sizeToFit, false, scale)
        
        // set draw property
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, borderWidth)
        CGContextSetStrokeColorWithColor(context, borderColor.CGColor)
        CGContextSetFillColorWithColor(context, backgroundColor.CGColor)
        
        // drow path
        let width = sizeToFit.width, height = sizeToFit.height
        CGContextMoveToPoint(context, width - halfBorderWidth, radius + halfBorderWidth)
        CGContextAddArcToPoint(context, width - halfBorderWidth, height - halfBorderWidth, width - radius - halfBorderWidth, height - halfBorderWidth, radius)  // 右下角角度
        CGContextAddArcToPoint(context, halfBorderWidth, height - halfBorderWidth, halfBorderWidth, height - radius - halfBorderWidth, radius) // 左下角角度
        CGContextAddArcToPoint(context, halfBorderWidth, halfBorderWidth, width - halfBorderWidth, halfBorderWidth, radius) // 左上角
        CGContextAddArcToPoint(context, width - halfBorderWidth, halfBorderWidth, width - halfBorderWidth, radius + halfBorderWidth, radius) // 右上角
        
        CGContextDrawPath(context, .FillStroke)

        // retrive output
        let output = UIGraphicsGetImageFromCurrentImageContext()
        
        // end draw
        UIGraphicsEndImageContext()
        
        return output
    }
}


// MARK: - Image 
//
extension UIImageView {
    override func FYAddCorner(radius radius: CGFloat) {
        self.image = self.image?.FYDrawRectWithRoundedCorner(radius: radius, sizeToFit: self.bounds.size)
    }
}

extension UIImage {
    
    func FYDrawRectWithRoundedCorner(radius radius: CGFloat, sizeToFit: CGSize) -> UIImage {
        
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: sizeToFit)
        
        // begin image
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.mainScreen().scale)
        
        let context = UIGraphicsGetCurrentContext()
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: UIRectCorner.AllCorners, cornerRadii: CGSize(width: radius, height: radius)).CGPath
        
        // get the boarder and clip the remaining
        CGContextAddPath(context, path)
        CGContextClip(context)
        
        // draw context in the rect
        self.drawInRect(rect)
        
        // draw the path
        CGContextDrawPath(context, .FillStroke)
        
        // get output
        let output = UIGraphicsGetImageFromCurrentImageContext()
        
        // stop image
        UIGraphicsEndImageContext()
        
        return output
    }
}
