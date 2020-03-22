//
//  BlueButtonView.swift
//  EDCCinema
//
//  Created by FanYu on 11/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class BlueButtonView: UIView {

    let blueColor = UIColor(red:0.168, green:0.574, blue:0.973, alpha:1)
    var tapped: Bool = false
    let actionLabel = UILabel()
    let priceLabel = UILabel()
    let shapeLayer = CAShapeLayer()
    let path = UIBezierPath()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let frameSize = self.bounds.size
        
        CGContextMoveToPoint(context, 0, 0)
        CGContextAddLineToPoint(context, frameSize.width, 0)
        CGContextAddLineToPoint(context, frameSize.width - 30, frameSize.height)
        CGContextAddLineToPoint(context, 0, frameSize.height)
        CGContextClosePath(context)
        blueColor.setFill()
        CGContextDrawPath(context, .EOFill)
    }
    
//    override func layoutSubviews() {
//        // bezier path
//        path.moveToPoint(CGPoint(x: 0, y: 0))
//        path.addLineToPoint(CGPoint(x: frame.size.width, y: 0))
//        path.addLineToPoint(CGPoint(x: frame.size.width - 30, y: frame.size.height))
//        path.addLineToPoint(CGPoint(x: 0, y: frame.size.height))
//        path.stroke()
//        
//        // shape layer
//        shapeLayer.frame = self.bounds
//        shapeLayer.strokeColor = blueColor.CGColor
//        shapeLayer.fillColor = blueColor.CGColor
//        shapeLayer.path = path.CGPath
//        
//        // add sub
//        self.layer.addSublayer(shapeLayer)
//        self.addSubview(actionLabel)
//        self.addSubview(priceLabel)
//    }

    
    func setup() {
        // tap
        tapped = false
        
        // shadow
        self.backgroundColor = UIColor.clearColor()
        self.layer.shadowOffset = CGSize(width: 0, height: 10)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 10
        self.layer.shadowColor = UIColor.lightGrayColor().CGColor
        
        // action label
        actionLabel.frame = CGRect(x: 20, y: 20, width: 200, height: 20)
        actionLabel.font = UIFont.systemFontOfSize(17)
        actionLabel.textColor = UIColor.whiteColor()
        actionLabel.textAlignment = .Left
        self.addSubview(actionLabel)
        
        // price label
        priceLabel.frame = CGRect(x: 180, y: 20, width: 50, height: 20)
        priceLabel.font = UIFont.systemFontOfSize(17)
        priceLabel.textColor = UIColor.whiteColor()
        priceLabel.textAlignment = .Right
        self.addSubview(priceLabel)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if touches.count == 1 {
            for touch in touches {
                if touch.phase == UITouchPhase.Ended || touch.phase == UITouchPhase.Cancelled {
                    tapped = !tapped
                    print("Tapped")
                }
            }
        }
    }
}
