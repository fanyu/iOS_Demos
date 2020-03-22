//
//  ViewController.swift
//  TransitionDemo
//
//  Created by FanYu on 5/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let bookView = BookPagingView()
    
    @IBAction func buttonTapped(sender: AnyObject) {
        //bookView.performCurl()
        //bookView.performRotation()
        bookView.performAlongBezier()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        bookView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        bookView.center = self.view.center
        self.view.addSubview(bookView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

