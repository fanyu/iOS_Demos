//
//  ViewController.swift
//  TestSearch
//
//  Created by FanYu on 7/22/15.
//  Copyright (c) 2015 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var pullDown = UISwipeGestureRecognizer(target: self, action: "pullGesture:")
        pullDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(pullDown)
        
        var pullUp = UISwipeGestureRecognizer(target: self, action: "pullGesture:")
        pullUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(pullUp)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pullGesture(gesture: UISwipeGestureRecognizer) {
        
        if gesture.direction == UISwipeGestureRecognizerDirection.Down {
            println("pull down")
            var searchView = self.storyboard?.instantiateViewControllerWithIdentifier("SearchView") as! SearchViewController
            
            self.presentViewController(searchView, animated: false, completion: nil)
        }
        
        if gesture.direction == UISwipeGestureRecognizerDirection.Up {
            println("pull Up")
            deleteAlertViewController(self)
        }
        
    }
    
    func deleteAlertViewController(sender: AnyObject) {
        var alertController = UIAlertController(title: "确定删除当前城市？", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        var deleteAction = UIAlertAction(title: "删除", style: UIAlertActionStyle.Destructive) { (ok) -> Void in
            println("Delete")
        }
        var cancleAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (ok) -> Void in
            println("Cancle")
        }
        alertController.addAction(deleteAction)
        alertController.addAction(cancleAction)
        
        sender.presentViewController(alertController, animated: true, completion: nil)
    }



}

