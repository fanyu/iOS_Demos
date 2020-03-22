//
//  ViewController.swift
//  TimeSelection
//
//  Created by FanYu on 17/10/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var buttonContentView: UIView!
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet weak var all16: UIButton!
    @IBOutlet weak var all24: UIButton!
    
    @IBAction func buttonTapped(sender: UIButton) {
        
        if sender.tag == 24 { // 24 hours
            sender.backgroundColor = UIColor.yellowColor()
            all16.backgroundColor = UIColor.whiteColor()
            setGray()
        } else if sender.tag == 25 { // 16H hours
            sender.backgroundColor = UIColor.yellowColor()
            all24.backgroundColor = UIColor.whiteColor()
            setGray()
        } else {    // self define
            buttons[24].backgroundColor = UIColor.whiteColor()
            buttons[25].backgroundColor = UIColor.whiteColor()
            if sender.backgroundColor == UIColor.whiteColor() {
                sender.backgroundColor = UIColor.lightGrayColor()
            } else {
                sender.backgroundColor = UIColor.whiteColor()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        layoutButtons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


// MARK: - laout buttons
extension ViewController {
    func layoutButtons() {
        // set title
        for i in 0 ... 25 {
            // set title
            let title = NSString(format: "%2d:00", i) as String
            buttons[i].setTitle(title, forState: UIControlState.Normal)
            
            buttons[i].backgroundColor = UIColor.lightGrayColor()
            
            buttons[i].setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
            buttons[i].setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Highlighted)
            buttons[i].setTitleShadowColor(UIColor.darkGrayColor(), forState: .Highlighted)
            buttons[i].setTitleShadowColor(UIColor.darkGrayColor(), forState: .Normal)
            
            buttons[i].layer.borderWidth = 0.5
            buttons[i].layer.borderColor = UIColor.lightGrayColor().CGColor
        }
        buttons[24].backgroundColor = UIColor.whiteColor()
        buttons[25].backgroundColor = UIColor.whiteColor()
    }
    
    func setGray() {
        for i in 0 ... 23 {
            buttons[i].backgroundColor = UIColor.lightGrayColor()
        }
    }
}
