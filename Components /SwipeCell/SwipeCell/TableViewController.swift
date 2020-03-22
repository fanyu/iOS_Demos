//
//  TableViewController.swift
//  SwipeCell
//
//  Created by FanYu on 15/10/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var dataArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setData() {
        for i in 1...20 {
            let text = NSString(format: "Nuber: %02d", i) as String
            dataArray.addObject(text)
        }
    }
    
    
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row] as? String
        
        return cell
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let more = UITableViewRowAction(style: .Normal, title: "More") { (action, index) -> Void in
            tableView.layoutIfNeeded()
            print("More Tapped")
        }
        more.backgroundColor = UIColor.lightGrayColor()
        
        
        let share = UITableViewRowAction(style: .Normal, title: "       Share      ") { (action, index) -> Void in
            
            // dismiss action
            tableView.editing = false
        }
        
        let delete = UITableViewRowAction(style: .Default, title: "Delete") { (action, index: NSIndexPath) -> Void in
            
            // remvoe cell
            tableView.editing = true
            self.dataArray.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([index], withRowAnimation: .Fade)
        }
        
        // color
        share.backgroundColor = UIColor.blueColor()
        //share.backgroundColor = UIColor(patternImage: UIImage(named: ""))
        
        // effect
        share.backgroundEffect = UIBlurEffect(style: .Dark)
        
        return [delete, more, share]
    }

    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }



}
