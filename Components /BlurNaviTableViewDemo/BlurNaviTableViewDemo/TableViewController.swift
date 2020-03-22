//
//  TableViewController.swift
//  BlurNaviTableViewDemo
//
//  Created by FanYu on 25/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit



class TableViewController: UITableViewController, EDCHeaderViewDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 20
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "test \(indexPath.item)"
        // Configure the cell...
        
        return cell
    }
    
}


// MARK: EDC Header
extension TableViewController {
    
    
    func setup() {
        
        // navi color and alpah
        self.navigationController?.navigationBar.setEDCNavigationBar(color: UIColor.orange, alpha: 1)
        
        // table view 每次可以回到原处，就是因为hederSize的高度是固定的
        let headerView = EDCHeaderView(
            image       : "car",
            headerSize  : CGSize(width: self.tableView.bounds.width, height: 100),
            delegate    : self,
            vc          : self)
        
        print(headerView.frame)
        
        self.tableView.tableHeaderView = headerView
    }
    
    
    // 有导航栏的时候，会自动执行一次 由 automaticallyAdjustsScrollViewInsets 调用
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 未完全透明的时候，改变透明度 100 为自加的保险数值
        if scrollView.contentOffset.y <= (100 - 64 + 100) {
            let headerView = tableView.tableHeaderView as! EDCHeaderView
            headerView.adjustHeaderView(scrollView.contentOffset.y, stickStatusBar: false)
        }
        
        //print("\(scrollView.contentOffset.y) \t \(self.navigationController?.navigationBar.coverView?.frame) \t \(self.navigationController?.navigationBar.frame)")
    }
}


//extension TableViewController {
//
//    func setup() {
//        // navigation bar
//        self.navigationController?.navigationBar.setMyBackgroundColor(UIColor.yellowColor())
//
//        // header image
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.width, height: 100))
//        imageView.image = UIImage(named: "car")
//        imageView.contentMode = .ScaleAspectFill
//
//        // init hederView
//        let headerView = ParallaxHeaderView(
//            style           : .Default,
//            subView         : imageView,
//            headerViewSize  : CGSizeMake(self.tableView.bounds.width, 100),
//            maxOffsetY      : -200,
//            delegate        : self
//        )
//
//        self.tableView.tableHeaderView = headerView
//    }
//
//    override func scrollViewDidScroll(scrollView: UIScrollView) {
//        print(scrollView.contentOffset.y)
//        let headerView = self.tableView.tableHeaderView as! ParallaxHeaderView
//        headerView.layoutHeaderViewDidScroll(scrollView.contentOffset)
//    }
//}
