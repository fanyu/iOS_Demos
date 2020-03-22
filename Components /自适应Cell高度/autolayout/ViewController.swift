//
//  ViewController.swift
//  autolayout
//
//  Created by FanYu on 21/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var tableVC = TableViewController()
    //var vv = EDCViewController()
    
    @IBAction func tableCellTapped(sender: UIButton) {
        //self.presentViewController(tableVC, animated: true, completion: nil)
        self.navigationController?.pushViewController(tableVC, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setup() {
        let label = UILabel()
        label.text = "Hello world"
        label.backgroundColor = UIColor(red:0.02, green:0.6, blue:0.99, alpha:1)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(label)
        
        label.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.view).offset(50)
            make.top.equalTo(self.view).offset(200)
        }
        
    }
}

