//
//  TableViewController.swift
//  autoLabel
//
//  Created by FanYu on 17/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    
    private var textStr = ["11112222222222222\n222222", "2\n3\n3\n3\n3", "5555555555555555\n555555555555555555\n555555555", "今天你是谁 明天我是谁 后台谁是我 你又是谁  我又是谁 哈哈恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚", "将cell的宽度设置为和tableView的宽度一样宽.这点很重要 如果cell的高度取决于table view的宽度（例如，多行的UILabel通过单词换行等方式），那么这使得对于不同宽度的table view，我们都可以基于其宽度而得到cell的正确高度。但是，我们不需要在-[tableView:cellForRowAtIndexPath]方法中做相同的处理，因为，cell被用到table view中时，这是自动完成的。也要注意，一些情况下，cell的最终宽度可能不等于table view的宽度"]
    
    var cell = TableViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return textStr.count * 90
    }

    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("CellForRowAt")
        
        //let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! TableViewCell
        
        // Configure the cell...
        cell.label.text = textStr[indexPath.row % textStr.count]
        self.cell = cell
        
        return cell
    }


    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        print("heightForRowAt")
        
        let contentSize = self.cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        
        //print(contentSize)
        
        return contentSize.height + 1
    }
}
