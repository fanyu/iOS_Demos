//
//  WaveView.swift
//  RotateAndScaleAnimation
//
//  Created by FanYu on 19/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class WaveView: UIView {

    var imageLayer = CALayer()
    var imageView = UIImageView(image: UIImage(named: "car"))
    
    
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
        
        // iamge 
        self.imageLayer.backgroundColor = UIColor.blackColor().CGColor
        self.imageLayer.contents = UIImage(named: "car")?.CGImage
        //self.layer.addSublayer(imageLayer)
        
        // iamge view
        self.addSubview(imageView)
        
        // pan 
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "handlePan:"))
    }
    
    override func layoutSubviews() {
        imageLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.width)
        imageLayer.position = self.layer.position
        
        imageView.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.width)
        imageView.center = self.center
    }
    
    func handlePan(pan: UIPanGestureRecognizer) {
        let transition = pan.translationInView(self)
        
        var initialPoint = CGPoint.zero
        
        var factorOfAngle: CGFloat = 0
        var factorOfScale: CGFloat = 0
        
        if pan.state == .Began {
            initialPoint = imageView.center//imageLayer.position
            
        } else if pan.state == .Changed {
            
            imageLayer.position = CGPoint(x: initialPoint.x, y: initialPoint.y + transition.y)
            
            imageView.center = CGPoint(x: initialPoint.x, y: initialPoint.y + transition.y)
            let Y = min(200, max(0, abs(transition.y)))
            // 一个开口向下,顶点(200/2,1),过(0,0),(200,0)的二次函数
            factorOfAngle = max(0, -4 / (200 * 200) * Y * (Y - 200))
            // 一个开口向下,顶点(200,1),过(0,0),(2*200,0)的二次函数
            factorOfScale = max(0, -1 / (200 * 200) * Y * (Y - 2 * 200))
            
            var transform = CATransform3DIdentity
            transform.m34 = -1 / 1000
            transform = CATransform3DRotate(transform, factorOfAngle * CGFloat(M_PI / 5), (transition.y > 0 ? -1 : 1), 0, 0)
            transform = CATransform3DScale(transform, 1 - factorOfScale * 0.2, 1 - factorOfScale * 0.2, 0)
            //imageLayer.transform = transform
            imageView.layer.transform = transform
        }
        
    }
        
}
