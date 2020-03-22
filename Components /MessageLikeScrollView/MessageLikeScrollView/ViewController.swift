//
//  ViewController.swift
//  MessageLikeScrollView
//
//  Created by FanYu on 9/6/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

// http://gold.xitu.io/#/entry/573c090371cfe448aa882c07


import UIKit


let identifier = "TableViewCell"


class ViewController: UIViewController {

    var tableView: UITableView!
    var scrollView: UIScrollView!
    
    var leadingSpaceOfLine: CGFloat = 0
    
    private var lastContentOffset: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
    }
}


extension ViewController {
    
    private func makeUI() {
        
        view.backgroundColor = UIColor.whiteColor()
        
        tableView = UITableView(frame: view.frame, style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 65
        tableView.separatorInset.left = 20
        tableView.registerNib(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        view.addSubview(tableView)
        
        
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = UIColor(red: 0.8, green: 0.5, blue: 0.9, alpha: 0.3)
        scrollView.contentInset.top = 64
        scrollView.scrollIndicatorInsets.top = 64
        scrollView.delegate = self
        scrollView.userInteractionEnabled = false
        view.addSubview(scrollView)
        
        tableView.addGestureRecognizer(scrollView.panGestureRecognizer)
    }
    
}



extension ViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! TableViewCell
        
        cell.iconImage.image = UIImage(named: "car")
        cell.titleLabel.text = "Item" + indexPath.row.description
        cell.timeLabel.text = "20:30:30"
        
        cell.selectionStyle = .None
        
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        guard let cell = cell as? TableViewCell else { return }
        
        cell.timeLabel.frame.origin.x = UIScreen.mainScreen().bounds.size.width + 100

        // set scroll view size
        scrollView.contentSize = CGSize(width: tableView.frame.width + 1, height: tableView.frame.height)
        
    }
    
}


extension ViewController: UITableViewDelegate {
    
}


extension ViewController {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print(scrollView.contentOffset)
        
        let offsetY = scrollView.contentOffset.y
        
        tableView.contentOffset.y = offsetY
        
        tableView.visibleCells.forEach { (cell) in
            (cell as? TableViewCell)?.timeLabel.frame.origin.x = -scrollView.contentOffset.x * 2 + UIScreen.mainScreen().bounds.size.width + 100
        }
    }
    
}

