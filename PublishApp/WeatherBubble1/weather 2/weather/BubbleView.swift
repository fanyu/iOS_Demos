//
//  BubbleViewController.swift
//  weather
//
//  Created by FanYu on 5/26/15.
//  Copyright (c) 2015 FanYu. All rights reserved.
//

import UIKit

class BubbleView: UIControl {
    
    
    func defineButton() {
        let button = UIButton(type: .System)
        button.frame = CGRectMake(100, 200, 100, 100)
        button.center = CGPoint(x: super.center.x, y: super.center.y)
        button.layer.cornerRadius = 50
        button.setTitle("New", forState: .Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        //button.backgroundColor = UIColor.redColor()
        button.backgroundColor = UIColor(red: 0.2, green: 0.4, blue: 0.6, alpha: 0.8)
        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        button.hidden = true
        
        button.titleLabel?.font = UIFont.systemFontOfSize(12)
        button.titleLabel?.lineBreakMode = NSLineBreakMode.ByCharWrapping
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = NSTextAlignment.Center
        
        
        
        
        super.addSubview(button)
    }
    func buttonAction(sender: UIButton!) {
        print("Button Tapped")
    }


//    @IBOutlet weak var currentLocation: UILabel!
//    @IBOutlet weak var longtitudeC: UILabel!
//    @IBOutlet weak var longtitudeD: UILabel!
//    @IBOutlet weak var latitudeC: UILabel!
//    @IBOutlet weak var latitudeD: UILabel!
//    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
//    @IBInspectable var lineWidth: CGFloat = 3 { didSet { setNeedsDisplay() } }
//    @IBInspectable var CGcolor = UIColor.greenColor().CGColor { didSet { setNeedsDisplay() } }
//    @IBInspectable var radius: CGFloat = 50 { didSet { setNeedsDisplay() } }
//    @IBInspectable var color: UIColor = UIColor.greenColor() { didSet { setNeedsDisplay() } }
//    @IBInspectable var cornerRadius: CGFloat = 50 { didSet { setNeedsDisplay() } }
    
//    var Center: CGPoint {
//        return convertPoint(center, fromCoordinateSpace: superview!)
//    }
    
    
//    @IBAction func dataButtonTapped(sender: UIButton) {
//        let tag = sender.tag
//        switch tag {
//        case 0: sender.titleLabel?.text = "Hasd"
//        }
//        
//    }

//    var button = UIButton.buttonWithType(.Custom) as! UIButton
//    
//    func buttonBubble(b: UIButton) ->UIButton {
//        var button = b
//        button.frame = CGRect(x: Center.x, y: Center.y, width: 100, height: 100)
//        button.layer.cornerRadius = 50
//        button.backgroundColor = UIColor.blueColor()
//        return button
//    }
    
//    var upperLine: CGPoint {
//        return convertPoint(tryloading.frame.origin, fromCoordinateSpace: superview!)
//    }
//
//    var testLabel = UILabel(frame: CGRect(x: 100, y: -200, width: 100, height: 100))
//    
//    func lBubble() {
//        tempeture.layer.masksToBounds = true
//        tempeture.layer.cornerRadius = cornerRadius
//        tempeture.textAlignment = NSTextAlignment.Center
//        tempeture.layer.borderWidth = 10
//        tempeture.layer.backgroundColor = UIColor.blueColor().CGColor
//        tempeture.font = UIFont(name: "Hoefler Text", size: 75.0)
//        tempeture.text = "32℃"
//        tempeture.textColor = UIColor.whiteColor()
//        
//        //testLabel.backgroundColor = UIColor(red: 0.9, green: 0.2, blue: 0.2, alpha: 1.0)
//    }
    
    enum BubbleCircle {
        case icon
        case temperature
        case humidity
        case wind
        case umbrella
        case pollution
        case sunrise
        case sundown
    }
    
//    @IBInspectable var d: CGFloat = 50
//    func calculateCoordinate(updown: String, leftright: String) ->CGPoint {
//        //var coordinate: CGPoint?
//        var x: CGFloat?
//        var y: CGFloat?
//        
//        switch updown {
//        case "up": y = Center.y + sqrt(3)*d/2
//        case "down": y = Center.y - sqrt(3)*d/2
//        default: y = Center.y
//        }
//        
//        switch leftright {
//        case "left": x = Center.x - d/2
//        case "right": x = Center.x + d/2
//        case "LeftCenter": x = Center.x - d
//        default: x = Center.x + d
//        }
//        
//        return CGPoint(x: x!, y: y!)
//    }
//    
//    @IBInspectable var difference: CGFloat = 0
//    
//    private func bezierPathForBubble(whichBubble: BubbleCircle)-> UIBezierPath {
//        var  bubbleCenter = Center
//        var bubbleRadius = radius - difference
//        
////        switch whichBubble {
////        case .temperature: bubbleCenter = Center
////        case .humidity: bubbleCenter = calculateCoordinate("up", leftright: "left")
////        case 
////        }
//        
//        let bubblePath = UIBezierPath(arcCenter: bubbleCenter, radius: bubbleRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
//        bubblePath.lineWidth = lineWidth
//        color.set()
//        return bubblePath
//    }
//    
//    override func drawRect(rect: CGRect) {
//        //bezierPathForBubble(BubbleCircle.temperature).fill()
//        //buttonBubble(button).layer.backgroundColor =
//    
//    }
    
}
