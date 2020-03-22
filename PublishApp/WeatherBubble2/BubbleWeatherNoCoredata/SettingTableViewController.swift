//
//  CandyTableViewController.swift
//  Search Bar
//
//  Created by Georgy Marrero on 6/10/15.
//  Copyright (c) 2015 Georgy Marrero. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    @IBAction func backBarButton(sender: UIBarButtonItem) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

    lazy var mySections: [SectionData] = {
        let setting = SectionData(title: "设置", data: "大小", "颜色", "折线图")
        let about = SectionData(title: "关于", data: "数据来源", "开源组件", "操作指南","我要点评")
        let app = SectionData(title: "软件", data: "天气泡", "微博")
        return [setting, about, app]
        }()
    
    var searchController = UISearchController()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(red: 20.0 / 255.0, green: 20.0 / 255.0, blue: 20.0 / 255.0, alpha: 1.0)
        // space before first section
        tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    // MARK: - TableView Data Source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return mySections.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mySections[section].numberOfItems
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return mySections[section].title
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor(red: 20.0 / 255.0, green: 20.0 / 255.0, blue: 20.0 / 255.0, alpha: 1.0)
        header.textLabel.textColor = UIColor.lightTextColor()
    }
    
    override func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let footer = view as! UITableViewHeaderFooterView
        footer.contentView.backgroundColor = UIColor(red: 20.0 / 255.0, green: 20.0 / 255.0, blue: 20.0 / 255.0, alpha: 1.0)
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("SettingCell") as! UITableViewCell
        cell.backgroundColor = UIColor(red: 38.0 / 255.0, green: 38.0 / 255.0, blue: 38.0 / 255.0, alpha: 1.0)
        let selectedView = UIView(frame: cell.frame)
        selectedView.backgroundColor = UIColor(red: 42.0 / 255.0, green: 127.0 / 255.0, blue: 254.0 / 255.0, alpha: 1.0)

        
        // Configure the cell
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.text = mySections[indexPath.section][indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.selectedBackgroundView = selectedView
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("SettingDetail", sender: tableView)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SettingDetail" {
            let candyDetailViewController = segue.destinationViewController as! UIViewController
           
            let indexPath = self.tableView.indexPathForSelectedRow()!
            let destinationTitle = self.mySections[indexPath.section][indexPath.row]
            candyDetailViewController.title = destinationTitle
            tableView.reloadData()// effect like deselect row
        }
    }
}
