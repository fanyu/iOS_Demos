//
//  CircleView.swift
//  CirculProgress
//
//  Created by FanYu on 4/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class CircleView: UIView {

    //let shapeView: UIView = UIView(frame: CGRect(x: 20, y: 20, width: 300, height: 300))
    
    let shapeLayer = CAShapeLayer()
    
    let animation1: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        animation.repeatCount = HUGE
        animation.removedOnCompletion = false
        //shapeLayer.addAnimation(animation, forKey: "end move")
        return animation
    }()
    
    let animation2: CABasicAnimation = {
        let animation2 = CABasicAnimation(keyPath: "strokeEnd")
        animation2.fromValue = 1
        animation2.toValue = 0
        animation2.duration = 2
        //animation2.repeatCount = HUGE
        //shapeLayer.addAnimation(animation2, forKey: "start mvoe")
        return animation2
    }()
    
    
    let gradient1: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 150, y: 0, width: 150, height: 300)
        gradient.startPoint = CGPoint(x: 0.5, y: 1)
        gradient.endPoint = CGPoint(x: 0.5, y: 0)
        gradient.colors = [UIColor.orangeColor().CGColor, UIColor.yellowColor().CGColor]
        gradient.locations = [0.5, 1]
        return gradient
    }()
    
    let gradient2: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: 150, height: 300)
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        gradient.colors = [UIColor.blueColor().CGColor, UIColor.redColor().CGColor]
        gradient.locations = [0, 0.5]
        return gradient
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        
        circleView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func circleView() {
        
        // path
        let path = UIBezierPath(ovalInRect: CGRect(x: 10, y: 10, width: 300 - 20, height: 300 - 20)).CGPath
        
        // shapeLayer
        shapeLayer.frame = bounds
        shapeLayer.position = self.center
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.lineWidth = 10
        shapeLayer.strokeColor = UIColor.blackColor().CGColor
        shapeLayer.path = path
        shapeLayer.strokeStart = 0
        shapeLayer.opacity = 0.5
        //shapeLayer.strokeEnd = 1
        
        shapeLayer.addAnimation(animation1, forKey: "33")
        //animation2.beginTime = CACurrentMediaTime() + 2
        //shapeLayer.addAnimation(animation2, forKey: "2")
        
        //gradient.mask = shapeLayer
        
        //self.shapeView.layer.addSublayer(gradient1)
        //self.shapeView.layer.addSublayer(gradient2)
        
        let graLayer = CALayer()
        graLayer.addSublayer(gradient1)
        graLayer.addSublayer(gradient2)
        //self.layer.addSublayer(graLayer)
        
        //graLayer.mask = shapeLayer
        self.layer.addSublayer(shapeLayer)
        //self.shapeLayer.addSublayer(shapeLayer)
    }
    

}
