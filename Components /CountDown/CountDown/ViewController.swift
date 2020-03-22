//
//  ViewController.swift
//  CountDown
//
//  Created by FanYu on 2/2/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = CountDownButton(count: 6,
            frame: CGRectMake(0, 0, 100, 44),
            animationType: AnimationType.ShakeAnimation,
            normalColor: nil,
            countColor: nil)
        
        button.center = self.view.center
        self.view.addSubview(button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

