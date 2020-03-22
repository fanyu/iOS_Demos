//
//  ViewController.swift
//  ColorfulLineIndicator
//
//  Created by FanYu on 4/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var width: CGFloat { return UIScreen.mainScreen().bounds.size.width }
    let line = LineView()
    let line2 = LineView()
    let line3 = LineView()
    
    var adder: CGFloat = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension ViewController {
    
    func lineView() {
        line.frame = CGRect(x: 0, y: 0, width: width, height: 3)
        line.center = self.view.center
        self.view.addSubview(line)
        self.view.backgroundColor = UIColor.blackColor()
        
        line2.frame = CGRect(x: 0, y: 50, width: width, height: 3)
        self.view.addSubview(line2)
        
        line3.frame = CGRect(x: 0, y: 100, width: width, height: 3)
        self.view.addSubview(line3)
        
        line.performAnimation()
        line2.performAnimation()
        line3.performAnimation()
        
        for i in 1 ... 10 {
            dispatchAfter(UInt64(i))
        }
    }
}


extension ViewController {
    
    func dispatchAfter(second: UInt64) {
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(second * NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            self.line.progress = self.adder / self.width
            self.line2.progress = (self.adder + 10) / self.width
            self.line3.progress = (self.adder + 30) / self.width

            self.adder += 50
        }
    }
}
