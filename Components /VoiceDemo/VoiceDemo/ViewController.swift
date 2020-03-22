//
//  ViewController.swift
//  VoiceDemo
//
//  Created by FanYu on 1/2/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let voiceView = VoiceView()
    
    @IBAction func changeButtonTapped(sender: AnyObject) {        
        UIView.animateWithDuration(1) { () -> Void in
            self.voiceView.progress = CGFloat(arc4random() % 400)
            self.voiceView.setNeedsLayout()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        voiceView.frame = CGRectMake(0, 0, 200, 400)
        voiceView.center = self.view.center
        self.view.addSubview(voiceView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

