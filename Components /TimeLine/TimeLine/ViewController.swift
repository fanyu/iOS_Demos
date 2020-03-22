//
//  ViewController.swift
//  TimeLine
//
//  Created by FanYu on 9/6/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

let identifier = "TimeLineTableViewCell"

class ViewController: UIViewController {

    var tableView: UITableView!
    var topLineView: UIView!
    var bottomLineView: UIView!
    
    var leadingSpaceOfLine: CGFloat = 0
    
    var numberOfRow = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
    }
    
    func injected() {
        print("I've been injected: (self)")
    }
}


extension ViewController {

    private func makeUI() {
        
        navigationItem.title = "Order Details"
        
        view.backgroundColor = UIColor.whiteColor()
        
        tableView = UITableView(frame: view.frame, style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.clearColor()
        tableView.backgroundColor = UIColor.clearColor()
        tableView.rowHeight = 65
        tableView.registerNib(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        view.addSubview(tableView)
        
        topLineView = UIView()
        bottomLineView = UIView()
        bottomLineView.backgroundColor = UIColor.darkGrayColor()
        
        view.addSubview(topLineView)
        view.addSubview(bottomLineView)
    }
    
}



extension ViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRow
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! TimeLineTableViewCell
        
        cell.upperLineView.backgroundColor = UIColor.blackColor()
        cell.bottomLineView.backgroundColor = indexPath.row == numberOfRow - 1 ? UIColor.orangeColor() : UIColor.blackColor()
        
        cell.selectionStyle = .None
        
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        guard let cell = cell as? TimeLineTableViewCell else { return }
        
        topLineView.backgroundColor = cell.upperLineView.backgroundColor
        bottomLineView.backgroundColor = UIColor.orangeColor()
        
        leadingSpaceOfLine = cell.convertPoint(cell.upperLineView.frame.origin, toView: view).x
        
        scrollViewDidScroll(tableView)
    }
}


extension ViewController: UITableViewDelegate {
    
}


extension ViewController {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        
        topLineView.frame = CGRect(x: leadingSpaceOfLine, y: 0, width: 2, height: -offsetY)
        
        let deltaY = view.frame.height - (scrollView.frame.height - scrollView.contentSize.height + offsetY)
        
        bottomLineView.frame = CGRect(x: leadingSpaceOfLine, y: deltaY, width: 2, height: view.frame.height)
    }
}
