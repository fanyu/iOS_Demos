//
//  CuteView.swift
//  CuteDrag
//
//  Created by FanYu on 19/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class CuteView: UIView {
    
    // view 
    var originView = UIView()
    var originViewFrame: CGRect?
    var originViewCenter: CGPoint?
    
    var dragView = UIView()
    var label: UILabel?
    var viscosity: CGFloat?

    // shape layer
    var shapeLayer = CAShapeLayer()
    
    // location 
    var r1: CGFloat?
    var r2: CGFloat?
    var x1: CGFloat?
    var y1: CGFloat?
    var x2: CGFloat?
    var y2: CGFloat?
    var centerDistance: CGFloat!
    var cos: CGFloat?
    var sin: CGFloat?
    
    var pointA: CGPoint?
    var pointB: CGPoint?
    var pointC: CGPoint?
    var pointD: CGPoint?
    var pointO: CGPoint?
    var pointP: CGPoint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        // self 
        self.backgroundColor = UIColor.whiteColor()
        
        // shapeLayer
        shapeLayer.strokeColor = UIColor.redColor().CGColor
        shapeLayer.fillColor = UIColor.redColor().CGColor   //fillColor?.CGColor
        self.layer.insertSublayer(shapeLayer, below: dragView.layer)
        
        // origin View
        originView.frame = CGRect(x: 50, y: 70, width: 40, height: 40)
        originView.backgroundColor = UIColor.redColor()
        originView.layer.cornerRadius = 20
        self.addSubview(originView)
        
        originViewCenter = originView.center
        originViewFrame = originView.frame
        originView.hidden = true
        
        // drag view 
        dragView.frame = CGRect(x: 50, y: 70, width: 40, height: 40)
        dragView.backgroundColor = UIColor.redColor()
        dragView.layer.cornerRadius = 20
        self.addSubview(dragView)
        
        // label
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        label?.textColor = UIColor.whiteColor()
        label?.textAlignment = .Center
        dragView.insertSubview(label!, atIndex: 0)
        
        // location
        self.r1 = originView.bounds.size.width / 2
        self.x1 = originView.center.x
        self.y1 = originView.center.y
        
        self.r2 = dragView.bounds.size.width / 2
        self.x2 = dragView.center.x
        self.y2 = dragView.center.y
        
        self.pointA = CGPoint(x: x1! - r1!, y: y1!)
        self.pointB = CGPoint(x: x1! + r1!, y: y1!)
        self.pointC = CGPoint(x: x2! + r2!, y: y2!)
        self.pointD = CGPoint(x: x2! - r2!, y: y2!)
        self.pointO = CGPoint(x: x1! - r1!, y: y1!)
        self.pointP = CGPoint(x: x2! + r2!, y: y2!)
        
        // pan gesture
        dragView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "handlePan:"))
        shakeAnimation()
    }

    override func drawRect(rect: CGRect) {
        
        self.x1 = originView.center.x
        self.y1 = originView.center.y
        self.x2 = self.dragView.center.x
        self.y2 = self.dragView.center.y
        
        self.centerDistance = sqrt((x2! - x1!) * (x2! - x1!) + (y2! - y1!) * (y2! - y1!))
        if centerDistance == 0 {
            self.cos = 1
            self.sin = 0
        } else {
            cos = (y2! - y1!) / centerDistance!
            sin = (x2! - x1!) / centerDistance!
        }
        
        // viscosity the larger you can draw long
        self.r1 = 20 - centerDistance / viscosity!
        
        pointA = CGPoint(x: x1!-r1!*cos!, y: y1!+r1!*sin!)  // A
        pointB = CGPoint(x: x1!+r1!*cos!, y: y1!-r1!*sin!)  // B
        pointD = CGPoint(x: x2!-r2!*cos!, y: y2!+r2!*sin!)  // D
        pointC = CGPoint(x: x2!+r2!*cos!, y: y2!-r2!*sin!)  // C
        pointO = CGPoint(x: pointA!.x + (centerDistance! / 2)*sin!, y: pointA!.y + (centerDistance / 2)*cos!)
        pointP = CGPoint(x: pointB!.x + (centerDistance! / 2)*sin!, y: pointB!.y + (centerDistance / 2)*cos!)
        
        originView.center = originViewCenter!
        originView.bounds = CGRect(x: 0, y: 0, width: 2 * r1!, height: 2 * r1!)
        originView.layer.cornerRadius = r1!
        
        let cutePath = UIBezierPath()
        cutePath.moveToPoint(pointA!)
        cutePath.addQuadCurveToPoint(pointD!, controlPoint: pointO!)
        cutePath.addLineToPoint(pointC!)
        cutePath.addQuadCurveToPoint(pointB!, controlPoint: pointP!)
        cutePath.moveToPoint(pointA!)

        if originView.hidden == false {
            shapeLayer.path = cutePath.CGPath
            self.layer.insertSublayer(shapeLayer, below: dragView.layer)
        }
    }
    
    
    func handlePan(pan: UIPanGestureRecognizer) {
        let location = pan.locationInView(self)
        
        if pan.state == .Began {
            
            originView.hidden = false
            removeShakeAnimation()
            
        } else if pan.state == .Changed {
            
            self.dragView.center = location
            if r1 <= 6 {
                originView.hidden = true
                shapeLayer.removeFromSuperlayer()
            }
            
        } else if pan.state == .Cancelled || pan.state == .Ended || pan.state == .Failed {
            
            originView.hidden = true
            shapeLayer.removeFromSuperlayer()
            
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.dragView.center = self.originViewCenter!
                }, completion: { (Bool) -> Void in
                    self.shakeAnimation()
            })
        }
        setNeedsDisplay()
    }
    
    // game center like
    func shakeAnimation() {
        // path
        let path = UIBezierPath(ovalInRect: CGRect(x: self.dragView.frame.origin.x, y: self.dragView.frame.origin.y, width: 20, height: 20))
        
        // shake animation
        let shakeAnimation = CAKeyframeAnimation(keyPath: "position")
        shakeAnimation.duration = 5
        shakeAnimation.calculationMode = kCAAnimationPaced
        shakeAnimation.removedOnCompletion = false
        shakeAnimation.repeatCount = HUGE
        shakeAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        shakeAnimation.fillMode = kCAFillModeForwards
        shakeAnimation.path = path.CGPath
        self.dragView.layer.addAnimation(shakeAnimation, forKey: "shake")
        
        // scale 
        let scaleX = CAKeyframeAnimation(keyPath: "transform.scale.x")
        scaleX.duration = 2
        scaleX.values = [1.0, 1.1, 1.0]
        scaleX.keyTimes = [0.0, 0.5, 1.0]
        scaleX.repeatCount = HUGE
        scaleX.autoreverses = true
        scaleX.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.dragView.layer.addAnimation(scaleX, forKey: "sacle X")
        
        let scaleY = CAKeyframeAnimation(keyPath: "transform.scale.y")
        scaleY.duration = 2.5
        scaleY.values = [1.0, 1.1, 1.0]
        scaleY.keyTimes = [0.0, 0.5, 1.0]
        scaleY.repeatCount = HUGE
        scaleY.autoreverses = true
        scaleY.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.dragView.layer.addAnimation(scaleY, forKey: "sacle Y")
    }
    
    func removeShakeAnimation() {
        self.dragView.layer.removeAllAnimations()
    }
}
