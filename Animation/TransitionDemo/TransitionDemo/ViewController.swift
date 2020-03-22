//
//  ViewController.swift
//  TransitionDemo
//
//  Created by FanYu on 5/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let transition = TransitionFlyInOut()
    let interactiveTransition = InteractiveTransition()
    let scale = ScaleTransition()
    
    @IBAction func unwindeSegue(sender: UIStoryboardSegue) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        // Do any additional setup after loading the view, typically from a nib.        
        self.interactiveTransition.sourceViewController = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // we override this method to manage what style status bar is shown
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return self.presentationController == nil ? UIStatusBarStyle.Default : UIStatusBarStyle.LightContent
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as! MenuViewController
        destinationVC.transitioningDelegate = self.scale//self.interactiveTransition//self.scale
        self.interactiveTransition.menuViewController = destinationVC
    }
}


