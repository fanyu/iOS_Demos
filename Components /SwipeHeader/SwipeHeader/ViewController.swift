//
//  ViewController.swift
//  SwipeHeader
//
//  Created by FanYu on 10/13/15.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var maskView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let edcHeader = EDCSwipeHeader()
        edcHeader.frame = CGRect(x: 50.0, y: 50.0, width: view.bounds.width - 100.0, height: 30.0)
        
        edcHeader.leftTitle = "Hello"
        edcHeader.rightTitle = "World"
        
        edcHeader.backgroundColor = UIColor.blueColor()
        edcHeader.selectedBackgroundViewColor = UIColor.whiteColor()
        edcHeader.titleColor = UIColor.whiteColor()
        edcHeader.selectedTitleColor = UIColor.blackColor()
        
        edcHeader.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        view.addSubview(edcHeader)
        
        bottomView.maskView = maskView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

