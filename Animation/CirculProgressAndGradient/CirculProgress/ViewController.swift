//
//  ViewController.swift
//  CirculProgress
//
//  Created by FanYu on 3/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let cirlce = CircleView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        cirlce.frame = self.view.bounds
        
        self.view.addSubview(cirlce)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}



