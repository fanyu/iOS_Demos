//
//  ViewController.swift
//  AppendMessage
//
//  Created by FanYu on 21/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var num = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension ViewController {
    
    // reload cell at index
    @IBAction func leftButtonTapped(sender: UIButton) {
        //print(self.tableView.visibleCells)
        self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 0), atScrollPosition: .Bottom, animated: true)
        print("to \t 03 \t yes")
        self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 3, inSection: 0)], withRowAnimation: .Right)
    }
    
    // jump to
    @IBAction func midButtonTapped(sender: UIButton) {
        self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 20, inSection: 0), atScrollPosition: .Bottom, animated: false)
        print("to \t 20 \t false")
    }
    
    // jump to
    @IBAction func rightButtonTapped(sender: UIButton) {
        self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 35, inSection: 0), atScrollPosition: .Bottom, animated: false)
        print("to \t 35 \t false")
    }
    
    // delete
    @IBAction func deleteButtonTapped(sender: UIButton) {
        num -= 1
        self.tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: num, inSection: 0)], withRowAnimation: .Top)
        self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: num - 1, inSection: 0), atScrollPosition: .Bottom, animated: true)
        print("delete \t \(self.tableView.numberOfRowsInSection(0))")
    }
    
    // add
    @IBAction func addButtonTapped(sender: UIButton) {
        num += 1
        self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: num - 1, inSection: 0)], withRowAnimation: .Bottom)
        self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: num - 1, inSection: 0), atScrollPosition: .Top, animated: true)
        print("add \t \(self.tableView.numberOfRowsInSection(0)) ")
    }
}


extension ViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numOfRows")
        return num
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        print("cellForRow")
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = "num   \(indexPath.row)"
        
        return cell
    }
}


extension ViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}