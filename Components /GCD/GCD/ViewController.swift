//
//  ViewController.swift
//  GCD
//
//  Created by FanYu on 17/1/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var imageView = UIImageView()
    var num:Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        imageView.center = self.view.center
        imageView.backgroundColor = UIColor(red:0.02, green:0.6, blue:0.99, alpha:1)
        self.view.addSubview(imageView)
        
        //loadImageOnBackground()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - Helper
extension ViewController {
    // Main Queue
    var GlobalMainQueue: dispatch_queue_t {
        return dispatch_get_main_queue()
    }
    // Global Priority High
    var GlobalUserInteractiveQueue: dispatch_queue_t {
        return dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)
    }
    // Global Priority Defaulr
    var GlobalUserInitiatedQueue: dispatch_queue_t {
        return dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)
    }
    // Global Priority Low
    var GlobalUtilityQueue: dispatch_queue_t {
        return dispatch_get_global_queue(QOS_CLASS_UTILITY, 0)
    }
    // Global Prioroty Background
    var GlobalBackgroundQueue: dispatch_queue_t {
        return dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)
    }
}


// MARK: - Buttosn
extension ViewController {
    
    @IBAction func afterTapped(sender: UIButton) {
        print("After Tapped")
        self.dispatchAfter()
    }
    
    @IBAction func onceTapped(sender: UIButton) {
        self.dispatchOnec()
        print("once Tapped")
    }
    
    @IBAction func barrierTapped(sender: UIButton) {
        self.dispatchBarrier()
    }
    @IBAction func applyTapped(sender: UIButton) {
        self.dispatchApply()
    }
    
    @IBAction func groupTapped(sender: UIButton) {
        self.dispatchGroups()
    }
    
}


// MARK: - Dispatch
extension ViewController {
    
    // self define 
    func createQueue() {
        
    }
    
    // dispatch_async
    func loadImageOnBackground() {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            print("\(NSDate()) /t global queue")
            
            // 耗时操作
            let url = NSURL(string: "https://500px.com/photo/388736")
            let data = NSData(contentsOfURL: url!)
            let image = UIImage(data: data!)
            
            // 更新界面 只有在主线程能操作UIKit。
            if data != nil {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    print("\(NSDate()) \t main queue")
                    self.imageView.image = image
                })
            }
        }
    }
    
    // dispatch_after
    func dispatchAfter() {
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2.0 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) { () -> Void in
            print("\(NSDate()) \t Dispatch after")
        }
    }
    
    // dispatch_once 
    func dispatchOnec() {
        
        struct Static {
            static var onceToken: dispatch_once_t = 0
        }
        dispatch_once(&Static.onceToken) { () -> Void in
            print("\(NSDate()) /t Dispatch Once ")
        }
    }
    
    // dispatch_barrier
    func dispatchBarrier() {
        let concurrentQueue = dispatch_queue_create("com.edc.concurrentQueue", DISPATCH_QUEUE_CONCURRENT)
        
        dispatch_async(concurrentQueue) { () -> Void in
            print("\(NSDate()) barrier queue before 1")
        }
        
        dispatch_async(concurrentQueue) { () -> Void in
            print("\(NSDate()) barrier queue before 2")
        }
        
        dispatch_barrier_async(concurrentQueue) { () -> Void in
            print("\(NSDate()) barrier queue barrier")
        }
        
        dispatch_async(concurrentQueue) { () -> Void in
            print("\(NSDate()) barrier queue after 1")
        }
        
        dispatch_async(concurrentQueue) { () -> Void in
            print("\(NSDate()) barrier queue after 2")
        }
    }
    
    // dispatch_apply 
    func dispatchApply() {
        let loopTimes: Int = 30
        dispatch_apply(loopTimes, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) { (Int) -> Void in
            print("\(NSDate()) dispatch applay \(self.num++)")
        }
    }
    
    // dispatch_groups
    func dispatchGroups() {
        let group = dispatch_group_create()
        
        for i in 1 ... 30 {
            dispatch_group_enter(group)
            print("\(NSDate()) group \(i)")
            dispatch_group_leave(group)
        }
        
        dispatch_group_notify(group, dispatch_get_main_queue()) { () -> Void in
            print("\(NSDate()) group notify")
        }
    }
}


