//
//  ViewController.swift
//  Keyboard
//
//  Created by FanYu on 8/19/15.
//  Copyright (c) 2015 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //let tap = UITapGestureRecognizer(target: self, action: <#Selector#>)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyBoard(note: NSNotification) {
        let userInfo = note.userInfo
    }


}

