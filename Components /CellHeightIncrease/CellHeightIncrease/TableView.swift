//
//  TableView.swift
//  CellHeightIncrease
//
//  Created by FanYu on 30/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class TableView: UITableView {

    var cell = TableViewCell()
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        self.registerClass(TableViewCell.self, forCellReuseIdentifier: "Cell")
        
        self.dataSource = self
        self.estimatedRowHeight = 50
    }
    
}

extension TableView: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! TableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TableViewCell
        
        // 必须在这个地方 为每个Cell都添加代理
        cell.delegate = self
        
        self.cell = cell
        // update constraint
        //cell.setNeedsUpdateConstraints()
        //cell.updateConstraints()
        
        return cell
    }
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        let size = cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
//        return size + 1
//    }
}

extension TableView: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    }
}

extension TableView: CellDelegate {
    func cellMoreButtonTapped(cell: TableViewCell) {
        
        
        if cell.loadMore {
            cell.loadMore = false
            cell.heightConstrait?.uninstall()
        } else {
            cell.loadMore = true
            cell.heightConstrait?.install()
        }
        
        //cell.once = !cell.once
        
        // reload cell
        let index = indexPathForCell(cell)
        self.reloadRowsAtIndexPaths([index!], withRowAnimation: .Left)
        cell.heightConstrait?.uninstall()

        print(index!.row)
    }
}