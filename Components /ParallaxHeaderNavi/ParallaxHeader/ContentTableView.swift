//
//  ContentTableView.swift
//  ParallaxHeader
//
//  Created by FanYu on 28/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class ContentTableView: UITableView {
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        //cell 
        self.registerClass(TableViewCell.self, forCellReuseIdentifier: "Cell")
        
        self.dataSource = self
        self.delegate = self
    }
}


// MARK: TableView DataSource
extension ContentTableView: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! TableViewCell
        
        cell.labelStr = CellData.title
        
        return cell
    }
}

// MARK: - Delegate 
extension ContentTableView: UITableViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //print("didScroll")
        
    }
}
