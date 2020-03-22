//
//  SecondViewController.swift
//  tabbartest
//
//  Created by FanYu on 20/10/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func awakeFromNib() {
        self.tabBarItem.title = "World"
        
        //self.tabBarItem.image
        //self.tabBarItem.image = UIImage(named: "loca")
    }

}

