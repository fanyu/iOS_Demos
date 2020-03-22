//
//  EDCContact.swift
//  ContactIndext
//
//  Created by FanYu on 8/1/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

class EDCContactTableView: UITableView {
    
    private var cell: UITableViewCell?
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setup() {
        // self 
        self.delegate = self
        self.dataSource = self
        
        // index
        self.sectionIndexColor = UIColor.greenColor()
        self.sectionIndexBackgroundColor = UIColor.orangeColor()
        self.sectionIndexTrackingBackgroundColor = UIColor.blackColor()
    
        // cell 
        self.registerClass(EDCContactCell.self, forCellReuseIdentifier: "Cell")
    }
}


// MARK: - Section and Index
extension EDCContactTableView {
    
    // Index
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return ContactData.indexNums
    }

    // Section Header Title
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ContactData.indexNums[section]
    }
    
    
    // Section 在不添加东西，改变label 和 background
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        // header background color
        view.tintColor = UIColor.yellowColor()
        
        // header title color
        let header = view as! UITableViewHeaderFooterView
        header.textLabel!.textColor = UIColor.whiteColor()
    }

    // 自己添加view 和 label 可以高度自定义
    //    // header View
    //    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        // view
    //        let sectionHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 30))
    //        sectionHeaderView.backgroundColor = UIColor(red:0.02, green:0.6, blue:0.99, alpha:1)//UIColor(red:0.97, green:0.97, blue:0.97, alpha:1)
    //
    //
    //        // label
    //        let label = UILabel(frame: CGRect(x: 14, y: 0, width: 30, height: 30))
    //        label.text = ContactData.indexNums[section]
    //        label.textColor = UIColor.blackColor()
    //        sectionHeaderView.addSubview(label)
    //
    //        return sectionHeaderView
    //    }
    //
    //    // Header height
    //    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        return 30
    //    }
    
}


// MARK: - Data Source
extension EDCContactTableView: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return ContactData.indexNums.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContactData.sectionNums[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("CellForRow")
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! EDCContactCell
        
        self.cell = cell
        
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        print("WillDisplay")
        
        self.cell!.textLabel?.text = "\(ContactData.sectionNums[indexPath.section][indexPath.item])"
    }
}



// MARK: Delegate
extension EDCContactTableView: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
}


extension EDCContactTableView {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print("DidScroll")
        
        UIControl().sendAction(Selector("suspend"), to: UIApplication.sharedApplication(), forEvent: nil)
    }
}
