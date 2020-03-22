//
//  ViewController.swift
//  ElcLine
//
//  Created by FanYu on 18/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let bouncdView = BounceView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        bouncdView.frame = self.view.bounds
        self.view.addSubview(bouncdView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

