//
//  MenuViewController.swift
//  TransitionDemo
//
//  Created by FanYu on 6/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    let transition = TransitionFlyInOut()
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    
    @IBOutlet var label: [UILabel]!
    var flag: Bool = false 
    @IBAction func showTapped(sender: UIButton) {
        flag = !flag
        for la in label {
            la.hidden = flag
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.transitioningDelegate = transition
        
//        view2.hidden = true
//        view4.hidden = true
//        view6.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
