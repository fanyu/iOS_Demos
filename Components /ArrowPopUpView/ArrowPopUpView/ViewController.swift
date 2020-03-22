//
//  ViewController.swift
//  ArrowPopUpView
//
//  Created by FanYu on 2/6/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = UIColor(red:1.00, green:0.94, blue:0.00, alpha:1.00)
        
        
        let popView = PopUpView(origin: CGPoint(x: 60, y: 60), width: 130, height: 200, backgroundColor: UIColor(red:0.11, green:0.67, blue:0.92, alpha:1.00))
        view.addSubview(popView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

