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
    var names = ["1", "2", "3", "4"]
    var currentIndex: Int?
    var reloadIndex: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        currentIndex = 0
        pageControllerAndIndicator()
        addSwipeGesture()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Swipe Gesture
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
            println("pull down")
        var searchView = self.storyboard?.instantiateViewControllerWithIdentifier("SearchViewController") as! SearchViewController
//                        var searchView = self.storyboard?.instantiateViewControllerWithIdentifier("TableView") as! SearchTableViewController
            
            self.presentViewController(searchView, animated: false, completion: nil)
        }
        
        if gesture.direction == UISwipeGestureRecognizerDirection.Up {
            println("pull Up")
//            if names.count != 1 {
//                deleteAlertViewController(self)
//            }
            
            if currentIndex != 0 {
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
            println("Delete: \(self.currentIndex!)")
            // delete and change number of pages
            self.names.removeAtIndex(self.currentIndex!)
            self.pageControl.numberOfPages = self.names.count
            self.reloadIndex = (self.currentIndex! + self.names.count) % self.names.count
            println("reloadIndex:\(self.reloadIndex)")
            var startingViewController = self.contentViewControllerAtIndex(self.reloadIndex!) as PageContentViewController
            var controllers = [startingViewController] as NSArray
            self.pageViewController.setViewControllers(controllers as [AnyObject],
                direction: UIPageViewControllerNavigationDirection.Forward,
                animated: false,
                completion: nil)
        }
        // cancle action
        var cancleAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (ok) -> Void in
            println("Cancle")
        }
        
        // set alert view color
        //alertController.view.tintColor = UIColor.whiteColor()
        var subview = alertController.view.subviews.first as! UIView;
        var alertContentView = subview.subviews.first as! UIView;
        alertContentView.backgroundColor = UIColor(red: 38.0 / 255.0, green: 38.0 / 255.0, blue: 38.0 / 255.0, alpha: 1.0)
        alertContentView.layer.cornerRadius = 5;
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancleAction)
        
        sender.presentViewController(alertController, animated: true, completion: nil)
    }

    
    // MARK: - Pagea Controller
    func pageControllerAndIndicator() {
        
        // page controller
        self.pageViewController = self.storyboard!.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self

        var startingViewController = self.contentViewControllerAtIndex(0) as PageContentViewController
        var viewControllers = [startingViewController] as NSArray
        currentIndex = 0
        
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
        self.pageControl.numberOfPages = names.count
        self.pageControl.hidesForSinglePage = true
        self.pageControl.pageIndicatorTintColor = UIColor(red: 29.0 / 255.0, green: 29.0 / 255.0, blue: 29.0 / 255.0, alpha: 0.8)
        self.pageControl.currentPageIndicatorTintColor = UIColor(red: 49.0 / 255.0, green: 49.0 / 255.0, blue: 49.0 / 255.0, alpha: 0.8)
        self.view.addSubview(pageControl)
    }
    
    
    // MARK: - Set Page Content
    func contentViewControllerAtIndex(index: Int) ->PageContentViewController! {

        if self.names.count == 0 || index >= self.names.count {
            return nil
        }

        var pageContentViewController = self.storyboard!.instantiateViewControllerWithIdentifier("PageContentViewController") as! PageContentViewController
        
        // set content
        println("Content:\(index)")
        println("Current:\(currentIndex)")
        pageContentViewController.pageCityName = self.names[index]
        pageContentViewController.pageIndex = index
        
        return pageContentViewController
    }
    
    
    // MARK: - page view controller data source
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var currentViewController = viewController as? PageContentViewController
        var index = currentViewController!.pageIndex
        
        // page indicator
        self.pageControl.currentPage = index!
        currentIndex = index
        
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index = index! - 1
        
//        if index == -1 {
//            index = self.names.count - 1
//        }
        
        return contentViewControllerAtIndex(index!)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var currentViewController = viewController as? PageContentViewController
        var index = currentViewController!.pageIndex
        
        // page indicator
        self.pageControl.currentPage = index!
        currentIndex = index

        if index == NSNotFound {
            return nil
        }
        
        index = index! + 1
        
//        // return first when last end
//        if index == self.names.count {
//            index = 0
//        }
        if (index == self.names.count) {
            return nil
        }
        
        return contentViewControllerAtIndex(index!)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        // The number of items reflected in the page indicator.
        return names.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        // The selected item reflected in the page indicator.
        return 0
    }

}

