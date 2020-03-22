//
//  HeartView.swift
//  RedHeart
//
//  Created by FanYu on 16/2/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//
import UIKit

class HeartView: UIView {

    private(set) var heartLayer: CAShapeLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup() 
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
    heartLayer = CAShapeLayer()
        heartLayer.strokeColor = UIColor.redColor().CGColor
        heartLayer.fillColor = UIColor(red: 1, green: 0.33, blue: 0.33, alpha: 1).CGColor
        heartLayer.lineWidth = 12
        heartLayer.lineCap = kCALineCapRound
        heartLayer.lineJoin = kCALineCapRound
        
        let points: [CGPoint] = 0.stride(to: M_PI * 2, by: 0.01).map {
            
            let x = pow(sin($0), 3)
            var y = 13 * cos($0)
            y -= 5 * cos(2 * $0)
            y -= 2 * cos(3 * $0)
            y -= cos(4 * $0)
            y /= 16
        
            return CGPoint(x: 320 + (x * 300), y: 280 + (y * -300))
        }
        
        let path = CGPathCreateMutable()
        CGPathAddLines(path, nil, points, points.count)
        
        heartLayer.path = path
        
        self.layer.addSublayer(heartLayer)
    }
    
    override func layoutSubviews() {
        heartLayer.bounds = self.bounds
    }
    
}
