//
//  ViewController.swift
//  UIPageViewControllerDemo
//
//  Created by FanYu on 7/13/15.
//  Copyright (c) 2015 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource {

    var pageImagePaths = ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg"]
    var pageTitles = [ "Over 200 Tips and Tricks", "Discover Hidden Features", "Bookmark Favorite Tip", "Free Regular Update", "Hello World" ]
    var pageViewController = UIPageViewController()
    
    @IBAction func backButtonTapped(sender: AnyObject) {
        var startingViewController = self.contentViewControllerAtIndex(0)
        var controllers = [startingViewController] as NSArray
        
        self.pageViewController.setViewControllers(controllers as [AnyObject],
            direction: UIPageViewControllerNavigationDirection.Forward,
            animated: false,
            completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.pageViewController = self.storyboard!.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        
        var startingViewController = self.contentViewControllerAtIndex(0) as PageContentViewController
        var viewControllers = [startingViewController] as NSArray
        self.pageViewController.setViewControllers(viewControllers as [AnyObject],
            direction: UIPageViewControllerNavigationDirection.Forward,
            animated: false,
            completion: nil)
        
        self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        self.addChildViewController(pageViewController)
        self.view.addSubview(pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func contentViewControllerAtIndex(index: Int) ->PageContentViewController! {
        print("\(index)")
        
        if self.pageImagePaths.count == 0 || index >= self.pageImagePaths.count {
            return nil
        }
        
        let pageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageContentViewController") as! PageContentViewController
        //pageContentViewController.titleText = self.pageTitles[index]
        pageContentViewController.imagePath = self.pageImagePaths[index]
        pageContentViewController.pageIndex = index
        
        return pageContentViewController
    }
    
    
    // MARK: - UIPageViewController DataSource
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let currentViewController = viewController as? PageContentViewController
        var index = currentViewController!.pageIndex
        
        if index == 0 {//|| index != nil {
            return nil
        }
        
        index = index! - 1
        
        return contentViewControllerAtIndex(index!)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let currentViewController = viewController as? PageContentViewController
        var index = currentViewController!.pageIndex
        
        if index == nil {
            return nil
        }
        
        index = index! + 1
        
//        if index == self.pageImagePaths.count {
//            return nil
//        }
        
        return contentViewControllerAtIndex(index!)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        // The number of items reflected in the page indicator.
        return pageImagePaths.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        // The selected item reflected in the page indicator.
        return 0
    }
}

