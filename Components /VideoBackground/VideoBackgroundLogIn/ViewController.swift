//
//  ViewController.swift
//  VideoBackgroundLogIn
//
//  Created by FanYu on 18/1/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    private let vc = VideoBackgroundViewController()
    
    @IBAction func popDidTapped(sender: UIButton) {
        self.presentViewController(vc, animated: true, completion: nil)
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

