//
//  ViewController.swift
//  CuteDrag
//
//  Created by FanYu on 19/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let dragView = CuteView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        dragView.frame = self.view.bounds
        dragView.viscosity = 20
        dragView.label?.text = "11"
        self.view.addSubview(dragView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

