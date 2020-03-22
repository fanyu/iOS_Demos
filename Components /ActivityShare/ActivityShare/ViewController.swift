//
//  ViewController.swift
//  ActivityShare
//
//  Created by FanYu on 3/3/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func showActivity(sender: UIButton) {
        
        let shareURL = NSURL(string: "http://www.apple.com/cn/iphone/compare/")!
        
        let activity = Activity(type: "Hello", title: "World", image: UIImage(named: "1")!)
        
        let activityVC = UIActivityViewController(activityItems: [shareURL], applicationActivities: [activity])
        
        presentViewController(activityVC, animated: true) { () -> Void in
            print("Done")
        }
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
