//
//  SecondViewController.swift
//  SearchControllerDemo
//
//  Created by FanYu on 27/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Again"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor(red: 0.1, green: 0.8, blue: 0.2, alpha: 1)]
        // hide back button
        self.navigationItem.setHidesBackButton(true, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        // enable interactive
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        print("DidAppear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        // remove delegate
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        print("WillDisappear")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
