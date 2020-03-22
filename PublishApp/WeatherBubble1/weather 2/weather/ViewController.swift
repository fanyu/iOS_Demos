//
//  ViewController.swift
//  weather
//
//  Created by FanYu on 6/8/15.
//  Copyright (c) 2015 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    
    var pageViewController: UIPageViewController?
    var inputCitis: NSArray = ["taiyuan", "hognkong"]
    
    // MARK: - View did load and memeory warning
    override func viewDidLoad() {
        super.viewDidLoad()

        // init UIPageViewController
        pageViewController = storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as? UIPageViewController
        pageViewController?.dataSource = self
        
        var startingViewController: PageContentViewController = viewControllerAtIndex(0)
        var viewControllers: NSArray = [startingViewController]
        
        pageViewController?.setViewControllers(viewControllers as [AnyObject] as [AnyObject], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        
        self.addChildViewController(pageViewController!)
        view.addSubview(pageViewController!.view)
        pageViewController?.didMoveToParentViewController(self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func viewControllerAtIndex(index: Int) ->PageContentViewController {
        return self.storyboard?.instantiateViewControllerWithIdentifier("PageContentViewController") as! PageContentViewController
    }
    
    // MARK: - PageViewControllerDataSource
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = PageContentViewController().pageIndex
        
        if index == 0 {
            return nil
        }
        
        index = index! - 1
        
        return viewControllerAtIndex(index!)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = PageContentViewController().pageIndex
        
        if index == NSNotFound {
            return nil
        }
        
        index = index! + 1
        
        return viewControllerAtIndex(index!)
    }

    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.inputCitis.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
