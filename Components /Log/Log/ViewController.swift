//
//  ViewController.swift
//  Log
//
//  Created by FanYu on 31/1/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        test()
        
        //print("\(__FILE__)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func printLog<T>(message: T,
        file: String = __FILE__,
        method: String = __FUNCTION__,
        line: Int = __LINE__)
    {
        let dateFormater = NSDateFormatter()
        dateFormater.timeStyle = .MediumStyle
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormater.stringFromDate(NSDate())
        
        #if DEBUG
            print("\(date) \((file as NSString).lastPathComponent)  \(method): \(message)")
        #endif
    }
    
    func test() {
        printLog("This is a test")
    }
    
}

