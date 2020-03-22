//
//  PopUpView.swift
//  ArrowPopUpView
//
//  Created by FanYu on 2/6/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

private let CellIdentifier = "PopUpViewTableViewCell"


class PopUpView: UIView {
    
    private var tableView = UITableView()
    private var origin = CGPoint()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(origin: CGPoint, width: CGFloat, height: CGFloat, backgroundColor: UIColor) {
        
        self.init(frame: CGRect(origin: origin, size: CGSize(width: width, height: height)))
        
        self.origin = origin
        
        self.backgroundColor = UIColor.clearColor()
        
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: width))
        backgroundView.backgroundColor = backgroundColor
        self.addSubview(backgroundView)
        
        tableView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clearColor()
        backgroundView.addSubview(tableView)
        
        tableView.registerNib(UINib(nibName: CellIdentifier, bundle: nil), forCellReuseIdentifier: CellIdentifier)
        
    }
    
    override func drawRect(rect: CGRect) {
        
        
        let context = UIGraphicsGetCurrentContext()
        print(origin)
        
        CGContextMoveToPoint(context, origin.x, origin.y)
        CGContextAddLineToPoint(context, origin.x + 10, origin.y - 10)
        CGContextAddLineToPoint(context, origin.x + 20, origin.y + 0)
        
        CGContextSetFillColorWithColor(context, UIColor.redColor().CGColor)
        CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
        
        CGContextClosePath(context)
        CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
        
    }
    
}


// MARK: - TableView Delegate 
//
extension PopUpView: UITableViewDelegate {
    
}


// MARK: - TableView DataSource
//
extension PopUpView: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as! PopUpViewTableViewCell
        
        //cell.backgroundColor = UIColor.clearColor()
        
        cell.textLabel?.text = indexPath.row.description
        
        return cell
    }
}
