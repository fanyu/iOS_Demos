//
//  ViewController.swift
//  BreathLight
//
//  Created by FanYu on 19/10/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var breathView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startBreath(UIColor.yellowColor(), offset: CGSize(width: 4, height: 8), frequency: 2)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func startBreath(color: UIColor, offset: CGSize, frequency: CFTimeInterval) {
        breathView.layer.shadowColor = color.CGColor
        breathView.layer.shadowOffset = offset
        breathView.layer.shadowOpacity = 0.9
        breathView.layer.shadowRadius = 15
        breathView.layer.masksToBounds = false
        
        // animation
        let animation = CABasicAnimation.init(keyPath: "shadowOpacity")
        animation.fromValue = 0.9
        animation.toValue = 0.2
        animation.duration = frequency
        animation.autoreverses = true
        animation.repeatCount = 5000
        breathView.layer.addAnimation(animation, forKey: "BreathLight")
    }
}

