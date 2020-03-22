//
//  ViewController.swift
//  PageandSearch
//
//  Created by FanYu on 7/28/15.
//  Copyright (c) 2015 FanYu. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UIPageViewControllerDataSource {

    var pageViewController = UIPageViewController()
    var pageControl = UIPageControl()
    var currentIndex: Int?
    var reloadIndex: Int?
    var noCityFlag: Bool?
    var data = SavedCity.getAllCities() ?? [SavedCity]()
//    var pageNums: Int = 0 { didSet{
//            println("didSet\(pageNums)")
//        if pageNums == 0 {
//            var searchView = self.storyboard?.instantiateViewControllerWithIdentifier("SearchViewController") as! SearchViewController
//            self.presentViewController(searchView, animated: false, completion: nil)
//        }
//        } }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentIndex = 0
        pageControllerAndIndicator()
        addSwipeGesture()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
    
        data = SavedCity.getAllCities() ?? [SavedCity]()
        self.pageControl.numberOfPages = data.count
        //self.pageControl.currentPage = 0
        //self.pageControl.currentPage = data.count - 1
        //pageNums = data.count
        //contentViewControllerAtIndex(self.data.count - 1)
    }
    
    override func viewDidAppear(animated: Bool) {
        // no city in list
        if noCityFlag == true {
            noCityFlag = false
            var searchView = self.storyboard?.instantiateViewControllerWithIdentifier("SearchViewController") as! SearchViewController
            self.presentViewController(searchView, animated: false, completion: nil)
            
            pageControllerAndIndicator()
        }
        
    }

    
    // MARK: - Swipe Gesture and Alert
    func addSwipeGesture() {
        var pullDown = UISwipeGestureRecognizer(target: self, action: "swipeGesture:")
        pullDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(pullDown)
        
        var pullUp = UISwipeGestureRecognizer(target: self, action: "swipeGesture:")
        pullUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(pullUp)
    }
    
    func swipeGesture(gesture: UISwipeGestureRecognizer) {
        
        if gesture.direction == UISwipeGestureRecognizerDirection.Down {
            var searchView = self.storyboard?.instantiateViewControllerWithIdentifier("SearchViewController") as! SearchViewController
            self.presentViewController(searchView, animated: false, completion: nil)
        }
        
        if gesture.direction == UISwipeGestureRecognizerDirection.Up {
//            if currentIndex != data.count - 1 {
//                deleteAlertViewController(self)
//            }
            if data.count != 1 {
                deleteAlertViewController(self)
            }
        }
        
    }
    
    func deleteAlertViewController(sender: AnyObject) {
        var alertController = UIAlertController(title: "", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        // attributed string to set colorful title
        let attributedString = NSAttributedString(string: "确定删除当前城市？", attributes: [NSForegroundColorAttributeName : UIColor.lightTextColor()]
        )
        alertController.setValue(attributedString, forKey: "attributedTitle")
        
        
        // delete action
        var deleteAction = UIAlertAction(title: "删除", style: UIAlertActionStyle.Destructive) { (ok) -> Void in
            
            // delete and change number of pages
            //if data.count != 0 {
            SavedCity.removeCity(self.data[self.currentIndex!])
            weatherService.saveContext()    // if not use this, the city will not delete from database
            
            self.data.removeAtIndex(self.currentIndex!)
            self.pageControl.numberOfPages = self.data.count
            if self.data.count != 0 {
            self.reloadIndex = (self.currentIndex! + self.data.count) % self.data.count
            
            var startingViewController = self.contentViewControllerAtIndex(self.reloadIndex!) as PageContentViewController
            var controllers = [startingViewController] as NSArray
            self.pageViewController.setViewControllers(controllers as [AnyObject],
                direction: UIPageViewControllerNavigationDirection.Forward,
                animated: false,
                completion: nil)
            self.pageControl.currentPage = self.reloadIndex!
                }
        }
        
        // cancle action
        var cancleAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (ok) -> Void in
        }
        
        // set alert view color
        //alertController.view.tintColor = UIColor.whiteColor()
        var subview = alertController.view.subviews.first as! UIView
        var alertContentView = subview.subviews.first as! UIView
        alertContentView.backgroundColor = UIColor(red: 38.0 / 255.0, green: 38.0 / 255.0, blue: 38.0 / 255.0, alpha: 1.0)
        alertContentView.layer.cornerRadius = 5
        
        alertController.addAction(cancleAction)
        alertController.addAction(deleteAction)
    
        sender.presentViewController(alertController, animated: true, completion: nil)
    }

    func dropAnimation() ->CAKeyframeAnimation {
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 50, y: 300))
        path.addCurveToPoint(CGPoint(x: 20, y: self.view.frame.size.height), controlPoint1: CGPoint(x: 40, y: 200), controlPoint2: CGPoint(x: 30, y: 100))
        let anim = CAKeyframeAnimation(keyPath: "position")
        anim.path = path.CGPath
        anim.rotationMode = kCAAnimationRotateAuto
        anim.duration = 0.5
        
        return anim
    }
    
    // MARK: - Pagea Controller
    func pageControllerAndIndicator() {
        
        // page controller
        self.pageViewController = self.storyboard!.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self

        if data.count != 0 {
        
            var startingViewController = self.contentViewControllerAtIndex(0) as PageContentViewController
            var viewControllers = [startingViewController] as NSArray
        
            pageViewController.setViewControllers(
                viewControllers as [AnyObject],
                direction: UIPageViewControllerNavigationDirection.Forward,
                animated: false,
                completion: nil)
        
            self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.height + 40)
            self.addChildViewController(pageViewController)
            self.view.addSubview(pageViewController.view)
            self.pageViewController.didMoveToParentViewController(self)
        
            // page indicator
            self.pageControl.frame = CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height - 8, 0, 0)
            self.pageControl.numberOfPages = data.count
            self.pageControl.hidesForSinglePage = true
            self.pageControl.pageIndicatorTintColor = UIColor(red: 29.0 / 255.0, green: 29.0 / 255.0, blue: 29.0 / 255.0, alpha: 0.8)
            self.pageControl.currentPageIndicatorTintColor = UIColor(red: 49.0 / 255.0, green: 49.0 / 255.0, blue: 49.0 / 255.0, alpha: 0.8)
            self.view.addSubview(pageControl)
            
        } else {
            noCityFlag = true
        }
    }
    
    
    // MARK: - Set Page Content
    func contentViewControllerAtIndex(index: Int) ->PageContentViewController! {

        if self.data.count == 0 {
            return nil
        }
        
        //self.pageControl.currentPage = index
        var pageContentViewController = self.storyboard!.instantiateViewControllerWithIdentifier("PageContentViewController") as! PageContentViewController
        
        // set content
        //currentIndex = index
        pageContentViewController.pageCityName = self.data[index].savedCityName
        pageContentViewController.pageIndex = index
        //self.pageControl.currentPage = index
        
        println("return:\(index), \(self.data[index].savedCityName)")
        
        return pageContentViewController
    }
    
    
    // MARK: - Page After & Before 
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var currentViewController = viewController as? PageContentViewController
        var index = currentViewController?.pageIndex    
        
        // page indicator
        self.pageControl.currentPage = index!
        currentIndex = index
        
//        if (index == 0) {//|| (index == NSNotFound) {
//            return nil
//        }
//        
//        index = index! - 1
        if index == NSNotFound {
            return nil
        } else if (index == 0) {
            index = self.data.count - 1
        } else {
            index = index! - 1
        }
        
        return contentViewControllerAtIndex(index!)
    }
    // after
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var currentViewController = viewController as? PageContentViewController
        var index = currentViewController!.pageIndex
        
        // page indicator
        self.pageControl.currentPage = index!
        currentIndex = index

//        if index == data.count - 1 {//NSNotFound {
//            return nil
//        }
//        
//        index = index! + 1
        if index == NSNotFound {
            return nil
        } else if index == self.data.count - 1 {
            index = 0
        } else {
            index = index! + 1
        }


        return contentViewControllerAtIndex(index!)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        // The number of items reflected in the page indicator.
        return data.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        // The selected item reflected in the page indicator.
        return 0
    }
}

