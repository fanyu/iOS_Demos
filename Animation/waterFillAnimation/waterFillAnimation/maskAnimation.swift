//
//  maskAnimation.swift
//  waterFillAnimation
//
//  Created by FanYu on 26/2/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

class maskAnimation: UIView {

    private let imageViewWidth: CGFloat = 104.0
    private let imageViewHeight: CGFloat = 157.0
    
    private var isAnimating: Bool = false
    
    let maskLayer = CAShapeLayer()
    
    let foregroundImageView = UIImageView(image: UIImage(named: "yellow"))
    let backgroundImageView = UIImageView(image: UIImage(named: "blue"))

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        maskLayer.path = UIBezierPath(rect: frame).CGPath
        
        backgroundImageView.frame = CGRect(x: 0, y: 0, width: imageViewWidth, height: imageViewHeight)
        self.addSubview(backgroundImageView)
        
        foregroundImageView.frame = CGRect(x: 0, y: 0, width: imageViewWidth, height: imageViewHeight)
        foregroundImageView.layer.mask = maskLayer
        self.addSubview(foregroundImageView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startFillAnimation() {
        isAnimating = true
        
        let fromPath = UIBezierPath(rect: self.bounds).CGPath
        let toPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: imageViewWidth, height: 0)).CGPath
        maskLayer.path = fromPath
        maskLayer.speed = 1
        maskLayer.removeAllAnimations()
        
        let basicAnimation = CABasicAnimation(keyPath: "path")
        basicAnimation.fromValue = fromPath
        basicAnimation.toValue = toPath
        basicAnimation.duration = 5
        
        maskLayer.addAnimation(basicAnimation, forKey: "mask path")
        maskLayer.path = toPath
    }
    
    func pauseFillAnimation() {
        isAnimating = false
        
        let pausedTime = maskLayer.convertTime(CACurrentMediaTime(), fromLayer: nil)
        maskLayer.speed = 0
        maskLayer.timeOffset = pausedTime
    }
    
    func resumeFillAnimation() {
        if isAnimating { return }
        
        isAnimating = true
        
        let pausedTime = maskLayer.timeOffset
        maskLayer.speed = 1.0
        maskLayer.timeOffset = 0
        maskLayer.beginTime = 0
        
        let timeSincePause = maskLayer.convertTime(CACurrentMediaTime(), fromLayer: nil) - pausedTime
        maskLayer.beginTime = timeSincePause
    }
}
