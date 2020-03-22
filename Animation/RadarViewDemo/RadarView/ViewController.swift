//
//  ViewController.swift
//  RadarView
//
//  Created by FanYu on 30/10/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var radarView: RadarView!
    
    // slider view
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var colorView: UIView!
    @IBAction func sliderChanged(sender: UISlider) {
        colorView.layer.timeOffset = Double(sender.value)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupRadar()
        //setupSliderView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


// MARK: - Radar
extension ViewController {

    func setupRadar() {
        view.backgroundColor = UIColor.whiteColor()//UIColor(red:0.397, green:0.795, blue:0.992, alpha:1)//UIColor.darkGrayColor()
        
        let radarSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.width)
        let frameX = (self.view.bounds.size.width - radarSize.width) / 2
        let frameY = (self.view.bounds.size.height - radarSize.height) / 2
        
        radarView = RadarView(frame: CGRect(x: frameX, y: frameY, width: radarSize.width, height: radarSize.height))
        self.view.addSubview(radarView)
    }
}


// MARK: - Color Change
extension ViewController {
    
    // 通过slider来控制时间offset，选取动画的不同时段，则可以获得从橘色到蓝色之间的任意颜色
    func setupSliderView() {
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.fromValue = UIColor.orangeColor().CGColor
        animation.toValue = UIColor.blueColor().CGColor
        animation.duration  = 1
        colorView.layer.addAnimation(animation, forKey: "Change Color")
        colorView.layer.speed = 0
    }
    
}

