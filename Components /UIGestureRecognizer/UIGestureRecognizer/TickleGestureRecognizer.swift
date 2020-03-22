//
//  TickleGestureRecognizer.swift
//  UIGestureRecognizer
//
//  Created by FanYu on 8/21/15.
//  Copyright (c) 2015 FanYu. All rights reserved.
//

import Foundation
import UIKit
import UIKit.UIGestureRecognizerSubclass

class TickleGestureRecognizer: UIGestureRecognizer {
    
    let requiredTickles = 2
    let distanceForTickleGesture: CGFloat = 25.0
    
    enum Direction: Int {
        case DirectionUnknown = 0
        case DirectionLeft
        case DirectionRight
    }
    
    var tickleCount: Int = 0
    var curTickleStart:CGPoint = CGPointZero
    var lastDirection: Direction = Direction.DirectionUnknown
    
    override func touchesBegan(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        if let touch = touches.first as? UITouch {
            self.curTickleStart = touch.locationInView(self.view)
        }
    }
    
}
