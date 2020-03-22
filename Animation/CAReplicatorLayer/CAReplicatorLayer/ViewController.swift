//
//  ViewController.swift
//  CAReplicatorLayer
//
//  Created by FanYu on 26/2/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var pulseView: ActivityIndicatorView!
    var dotsView: ActivityIndicatorView!
    var dotsTriangleView: ActivityIndicatorView!
    var gridDotsView: ActivityIndicatorView!
    
    @IBAction func animation(sender: UIButton) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.lightGrayColor()
        
        self.view.layer.cornerRadius = 30
        
        let itemSize: CGFloat = 80.0
        
        pulseView = ActivityIndicatorView(
            frame           : CGRect(x: 50, y: itemSize, width: itemSize, height: itemSize),
            indicatorType   : ActivityIndicatorType.Pulse,
            tintColor       : UIColor.redColor(),
            indicatorSize   : itemSize)
        view.addSubview(pulseView)
        
        dotsView = ActivityIndicatorView(
            frame           : CGRect(x: 150, y: itemSize, width: itemSize, height: itemSize),
            indicatorType   : ActivityIndicatorType.ThreeDotsScale,
            tintColor       : UIColor.blueColor(),
            indicatorSize   : itemSize)
        view.addSubview(dotsView)
        
        dotsTriangleView = ActivityIndicatorView(
            frame           : CGRect(x: 250, y: itemSize, width: itemSize, height: itemSize),
            indicatorType   : ActivityIndicatorType.DotTriangle,
            tintColor       : UIColor.yellowColor(),
            indicatorSize   : itemSize)
        view.addSubview(dotsTriangleView)
        
        gridDotsView = ActivityIndicatorView(
            frame           : CGRect(x: 50, y: itemSize + 100, width: itemSize, height: itemSize),
            indicatorType   : ActivityIndicatorType.GridDots,
            tintColor       : UIColor.orangeColor(),
            indicatorSize   : itemSize)
        view.addSubview(gridDotsView)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        pulseView.startAnimating()
        dotsView.startAnimating()
        dotsTriangleView.startAnimating()
        gridDotsView.startAnimating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

