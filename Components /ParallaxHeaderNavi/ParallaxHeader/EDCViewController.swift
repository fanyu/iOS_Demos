//
//  EDCViewController.swift
//  ParallaxHeader
//
//  Created by FanYu on 28/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit
import SnapKit

class EDCViewController: UIViewController {
    
    private var tableView = ContentTableView()
    private var headerView = HeaderImageView()
    private var heightConstraint: Constraint? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        setup()
        //setupNaviBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.addObserver(self, forKeyPath: "contentOffset", options: .New, context: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        tableView.removeObserver(self, forKeyPath: "contentOffset")
    }
    
    private func setupNaviBar() {
        // navi abr transparent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        // slef define cover view
        let coverView = UIView(frame: CGRect(x: 0, y: -20, width: CGRectGetWidth((self.navigationController?.navigationBar.bounds)!), height: 64))
        coverView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        coverView.backgroundColor = UIColor.whiteColor()
        coverView.alpha = 0
        
        // sub
        //objc_setAssociatedObject(coverView, nil, coverView.self, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        self.navigationController?.navigationBar.insertSubview(coverView, atIndex: 0)
    }
    
    private func setup() {
        // navi 
        self.navigationController?.navigationBar.setEDCNavigationBar(color: UIColor.whiteColor(), alpha: 0)
        
        // table 
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.clearColor()
        
        // header 
        headerView.imageStr = HeaderImageManager.iamge1
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        // sub
        self.view.addSubview(tableView)
        self.view.insertSubview(headerView, belowSubview: tableView)
        
        // constraint 
        headerView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.view)
            make.left.right.equalTo(self.view)
            heightConstraint = make.height.equalTo(headerView.height).constraint
        }
        tableView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view).inset(UIEdgeInsets(top: headerView.height, left: 0, bottom: 0, right: 0))
        }
    }
    
}

// MARK: - Observe
extension EDCViewController {
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if keyPath == "contentOffset" {
            let deltaY = change![NSKeyValueChangeNewKey]?.CGPointValue.y
            handleParallax(deltaY!)
            handleNaviBar(deltaY!)
            print(deltaY)
        }
    }
    
    private func handleParallax(offset: CGFloat) {
        // scroll down
        if offset < 0 {
            heightConstraint?.updateOffset(headerView.height - offset)
        } else {
            heightConstraint?.updateOffset(headerView.height)
        }
    }
    
    private func handleNaviBar(offset: CGFloat) {
        
    }

}