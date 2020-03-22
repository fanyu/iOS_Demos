//
//  VoiceView.swift
//  VoiceDemo
//
//  Created by FanYu on 1/2/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

class VoiceView: UIView {
    
    var progress: CGFloat = 0
    
    private let outlineView = UIView()
    let outlineLayer = CAShapeLayer()
    let rectLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        // self blue
        self.backgroundColor = UIColor(red:0.02, green:0.6, blue:0.99, alpha:1)
    }
    
    override func layoutSubviews() {
        
        // self 
        let width = self.bounds.width
        let height = self.bounds.height
        
        // outline layer : green color
        let path = UIBezierPath(roundedRect: CGRectMake(0, 0, width, height), byRoundingCorners: UIRectCorner.AllCorners, cornerRadii: CGSizeMake(width / 2, width / 2))
        outlineLayer.path = path.CGPath
        outlineLayer.fillColor = UIColor.greenColor().CGColor
        outlineLayer.strokeColor = UIColor(red:0.2, green:0.2, blue:0.2, alpha:1).CGColor
        
        // outline view : yellow color
        outlineView.frame = self.bounds
        outlineView.backgroundColor = UIColor.yellowColor()
        outlineView.clipsToBounds = true
        
        outlineView.layer.mask = outlineLayer
        outlineView.clipsToBounds = true
        
        self.addSubview(outlineView)
        
        // rect layer : red color
        let pathForRect = UIBezierPath(rect: CGRectMake(0, 0, width, progress))
        rectLayer.path = pathForRect.CGPath
        rectLayer.fillColor = UIColor.redColor().CGColor
        
        outlineView.layer.addSublayer(rectLayer)
    }
}
