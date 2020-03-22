//
//  TableViewController.swift
//  autolayout
//
//  Created by FanYu on 22/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit
import Rainbow

class TableViewController: UITableViewController {
    
    var cell = UITableViewCell()
    var rowHeightCache = NSCache()
    var num: CGFloat = 0
    var cellCache = NSCache()
    
    var fpsView = FPSView(frame: CGRectZero)
    
    var needLoadArr = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setup() {
        
        self.tableView.registerClass(CardViewCell.self, forCellReuseIdentifier: "CardCell")
        self.tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.registerClass(PicturesCell.self, forCellReuseIdentifier: "PictureCell")
        
        //self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 60
    
        // frame per second 
        fpsView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        self.tableView.addSubview(fpsView)
        
        self.navigationController?.title = "\(fpsView.fps)"
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print( ContentData.titles.count * 50)
        
        return ContentData.titles.count * 50
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("CellForRowAt \(indexPath.row)--- \(num++)".blue)
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! TableViewCell
        
        if needLoadArr.count > 0 && needLoadArr.indexOfObject(indexPath) == NSNotFound {
            return cell
        }
        
        return handleOneTypeCell(cell, withIndexPath: indexPath.row)
//        self.cell = cell
//        cell.portraitView.image = imageManager.image1
//        cell.titleView.title = ContentData.titles[indexPath.row % ContentData.titles.count]
//        cell.textView.text = ContentData.texts[indexPath.row % ContentData.titles.count]
        
        // update constraints
        //cell.setNeedsUpdateConstraints()
        //cell.updateConstraints()
        
        //return cell
        
        //return handleCellData(indexPath.row)
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        print("willDisplayCell")
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //print("heightForRowAt")
        
        var height = rowHeightCache.objectForKey(indexPath.row)
        
        if height == nil {
            let contentSize = self.cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
            rowHeightCache.setObject(contentSize.height + 1, forKey: indexPath.row)
            height = contentSize.height + 1
            //print("new new new new new new new new new ")
        }
        
        return height as! CGFloat
        //return contentSize.height + 1
    }
}



extension TableViewController {
    private func handleCellData(indexPath: Int) ->UITableViewCell {
        
        //let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TableViewCell
        
        if indexPath % ContentData.titles.count == 0 {
            //print("CardCell")
            let cell = tableView.dequeueReusableCellWithIdentifier("CardCell") as! CardViewCell
            
            self.cell = cell
            
            cell.portraitView.image = imageManager.image2
            cell.titleView.title = "Edison"
            
            return cell
            
        } else if indexPath % ContentData.titles.count == 3 {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("PictureCell") as! PicturesCell
            self.cell = cell
            
            cell.portraitView.image = imageManager.image1
            cell.titleView.title = "Yo Yo Yo Yo"
            cell.textView.text = ContentData.texts[indexPath % ContentData.titles.count]
            cell.pic1.image = imageManager.image3
            cell.pic2.image = imageManager.image4
            
            return cell
            
        } else {
            //print("InfoCell")
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! TableViewCell
            
            self.cell = cell
            
            cell.portraitView.image = imageManager.image1
            cell.titleView.title = ContentData.titles[indexPath % ContentData.titles.count]
            cell.textView.text = ContentData.texts[indexPath % ContentData.titles.count]
            
            // update constraints
            //cell.setNeedsUpdateConstraints()
            //cell.updateConstraints()
            
            return cell
        }
    }
    
    private func handleOneTypeCell(cell: TableViewCell, withIndexPath indexPath: Int) ->UITableViewCell {
        
        self.cell = cell
        cell.portraitView.image = imageManager.image1
        cell.titleView.title = ContentData.titles[indexPath % ContentData.titles.count]
        cell.textView.text = ContentData.texts[indexPath % ContentData.titles.count]
        
        return cell
    }
}


// skip load when scroll too fast
extension TableViewController {
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        needLoadArr.removeAllObjects()
    }
    
    override func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let indexPath = tableView.indexPathForRowAtPoint(CGPointMake(0, targetContentOffset.memory.y))
        let currentIndexPath = tableView.indexPathsForVisibleRows?.first
        let skipCount: Int = 8
        
        if labs(currentIndexPath!.row - indexPath!.row) > skipCount {
            let temp: NSArray = tableView.indexPathsForRowsInRect(CGRectMake(0, targetContentOffset.memory.y, self.view.frame.width, self.view.frame.height))!
            let array: NSMutableArray = NSMutableArray(array: temp)
            
            if velocity.y < 0 {
                let indexPathRow = temp.lastObject?.row
                if (indexPathRow! + 3) < ContentData.titles.count * 50 {
                    array.addObject(NSIndexPath(forRow: indexPathRow! + 1, inSection: 0))
                    array.addObject(NSIndexPath(forRow: indexPathRow! + 2, inSection: 0))
                    array.addObject(NSIndexPath(forRow: indexPathRow! + 3, inSection: 0))
                }
            } else {
                let indexPathRow = temp.firstObject?.row
                if indexPathRow > 3 {
                    array.addObject(NSIndexPath(forRow: indexPathRow! - 3, inSection: 0))
                    array.addObject(NSIndexPath(forRow: indexPathRow! - 2, inSection: 0))
                    array.addObject(NSIndexPath(forRow: indexPathRow! - 1, inSection: 0))
                }
            }
            needLoadArr.addObject(array)
        }
    }

    override func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        if tableView.indexPathsForVisibleRows?.count <= 0 {
            return
        }
        // shoule bind date again 
//        
//        if tableView.visibleCells.count > 0 {
//            for item in tableView.visibleCells {
//                handleOneTypeCell(item, withIndexPath: <#T##Int#>)
//            }
//        }
    }
}