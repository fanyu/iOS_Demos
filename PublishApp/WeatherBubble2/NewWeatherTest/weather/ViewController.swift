//
//  ViewController.swift
//  
//
//  Created by FanYu on 7/16/15.
//
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource {

    var pageController = UIPageViewController()
    var data = SavedCity.getAllCities() ?? [SavedCity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageContentViewControllerAtIndex(index: Int) ->RootViewController {
        var pageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageContentViewController") as! RootViewController
        var currentCityID = data[index].sID
        
        pageContentViewController.currentLocation.text = "dsaf"
        return pageContentViewController
    }
    
    // MARK: - page controller data source 
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var currentPageContent = viewController as! RootViewController
        var index = currentPageContent.pageIndex
        
        if index == 0 {
            index = data.count
        }
        
        index = index! - 1
        
        return pageContentViewControllerAtIndex(index!)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
    var currentPageContent = viewController as! RootViewController
        var index = currentPageContent.pageIndex
        
        if index == data.count - 1 {
            index = -1
        }
        
        index = index! + 1
        
        return pageContentViewControllerAtIndex(index!)
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
