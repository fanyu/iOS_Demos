//
//  TableViewController.swift
//  SocialShare
//
//  Created by FanYu on 2/3/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit


class TableViewController: UITableViewController {

    let text = ["WeChat", "Weibo", "QQ", "System", "Pocket", "Alipay"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        cell.textLabel?.text = text[indexPath.row]
        
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            performSegueWithIdentifier("WeChat", sender: nil)
        case 1:
            performSegueWithIdentifier("Weibo", sender: nil)
        case 2:
            performSegueWithIdentifier("QQ", sender: nil)
        case 3:
            performSegueWithIdentifier("System", sender: nil)
        case 4:
            performSegueWithIdentifier("Pocket", sender: nil)
        case 5:
            performSegueWithIdentifier("Alipay", sender: nil)
        default:
            break
        }
    }
}
