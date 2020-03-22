//
//  ViewController.swift
//  ScaleHeaderTableView
//
//  Created by FanYu on 9/14/15.
//  Copyright (c) 2015 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var customView = UIView(frame: CGRectMake(UIScreen.mainScreen().bounds.size.width/2 - 50, 100, 100, 100))
        
        tableView.delegate = self
        tableView.dataSource = self
        
        var headerView = HeaderView(tableView: tableView, height: 300, backgroundImage: UIImage(named: "car"), foregroundView: customView)
        
        tableView.zoomHeaderView = headerView
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


extension ViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        
        cell.textLabel?.text = "\(indexPath.item)"
        return cell
    }
}


extension UITableView {
    private struct AssociatedKeys {
        static var DescriptiveName = "HeaderView"
    }
    
    var zoomHeaderView:HeaderView?{
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.DescriptiveName) as? HeaderView
        }
        set{
            if let newValue = newValue{
                willChangeValueForKey("zoomHeaderView")
                objc_setAssociatedObject(self, &AssociatedKeys.DescriptiveName, newValue as HeaderView?, UInt(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
                didChangeValueForKey("zoomHeaderView")
            }
        }
    }
}
