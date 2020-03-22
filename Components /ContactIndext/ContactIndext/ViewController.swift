//
//  ViewController.swift
//  ContactIndext
//
//  Created by FanYu on 8/1/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let contactTV = EDCContactTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        contactTV.frame = self.view.frame
        self.view.addSubview(contactTV)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

