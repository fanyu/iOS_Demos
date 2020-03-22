//
//  ViewController.swift
//  UIProgressView
//
//  Created by FanYu on 3/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!

    let edcView = EDCProgressView(frame: CGRect(x: 64, y: 64, width: 100, height: 10))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.addSubview(edcView)
        
        progressView.progressTintColor = UIColor.orangeColor()
        progressView.setProgress(0.9, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

