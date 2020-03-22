//
//  ViewController.swift
//  BlurEffectView
//
//  Created by FanYu on 17/3/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var visualEffectView: UIVisualEffectView = {
       let effectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Light))
        effectView.frame = self.view.bounds
        effectView.alpha = 0.6
        return effectView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let imageView = UIImageView(image: UIImage(named: "1"))
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 400)
        self.view.addSubview(imageView)
        
        imageView.addSubview(visualEffectView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

