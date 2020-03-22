//
//  ViewController.swift
//  waterFillAnimation
//
//  Created by FanYu on 26/2/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let maskView = maskAnimation(frame: CGRect(x: 0, y: 0, width: 104, height: 157))
    
    @IBAction func startAnimation(sender: UIButton) {
        maskView.startFillAnimation()
    }
    
    @IBAction func pauseAnimation(sender: UIButton) {
        maskView.pauseFillAnimation()
    }
    
    @IBAction func resumeAnimation(sender: UIButton) {
        maskView.resumeFillAnimation()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addSubview(maskView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

