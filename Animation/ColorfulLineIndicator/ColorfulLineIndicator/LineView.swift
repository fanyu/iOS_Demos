//
//  LineView.swift
//  ColorfulLineIndicator
//
//  Created by FanYu on 4/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class LineView: UIView {

    let lineGradientLayer = CAGradientLayer()
    let maskLayer = CALayer()
    
    var progress: CGFloat {
        get {
            return maskLayer.frame.size.width
        }
        set {
            // 每次设置一个新数值时，都会执行一次layoutSubviews
            maskLayer.frame.size.width = newValue * bounds.size.width
            setNeedsLayout()
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

    func setup() {
        backgroundColor = UIColor.whiteColor()
        
        // gradient layer
        lineGradientLayer.startPoint = CGPoint(x: 0, y: 0)
        lineGradientLayer.endPoint = CGPoint(x: 1, y: 0)
        lineGradientLayer.colors = colors() as [AnyObject]
        layer.addSublayer(lineGradientLayer)
        
        // mask layer
        maskLayer.backgroundColor = UIColor.blackColor().CGColor
        layer.mask = maskLayer
        
    }
    
    // 必须在layout Subview 时候 设置frame，否则在init时候，LineView还没有Frame，则设置为bounds时，为(0,0,0,0)
    override func layoutSubviews() {
        lineGradientLayer.frame = bounds
        maskLayer.frame.size.height = bounds.size.height
        
    }
    
    func colors() ->NSMutableArray {
        let colors = NSMutableArray()
        for var hue = 0; hue <= 360; hue += 5 {
            let color = UIColor(hue: CGFloat(hue) / 360, saturation: 1.0, brightness: 1.0, alpha: 1.0)
            colors.addObject(color.CGColor)
        }
        return colors
    }
    
    func shiftColor(colors: NSArray) ->NSArray {
        let mutable = NSMutableArray(array: colors.mutableCopy() as! [AnyObject])
        let last = mutable.lastObject
        mutable.removeLastObject()
        mutable.insertObject(last!, atIndex: 0)
        
        return mutable
    }
    
    func performAnimation() {
        
        let fromColor = lineGradientLayer.colors
        let toColor = shiftColor(fromColor!)
        lineGradientLayer.colors = toColor as [AnyObject]
        
        let shiftAnimation = CABasicAnimation(keyPath: "colors")
        shiftAnimation.fromValue = fromColor
        shiftAnimation.toValue = toColor
        shiftAnimation.duration = 0.08
        shiftAnimation.removedOnCompletion = true
        shiftAnimation.fillMode = kCAFillModeForwards
        shiftAnimation.delegate = self
        lineGradientLayer.addAnimation(shiftAnimation, forKey: "animation")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        performAnimation()
    }
}
