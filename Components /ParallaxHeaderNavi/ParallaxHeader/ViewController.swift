//
//  ViewController.swift
//  ParallaxHeader
//
//  Created by FanYu on 28/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var parallaxVC = EDCViewController()
    
    @IBAction func parallaxTapped(sender: UIButton) {
        self.navigationController?.pushViewController(parallaxVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

