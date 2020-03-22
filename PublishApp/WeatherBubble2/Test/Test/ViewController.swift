//
//  ViewController.swift
//  Test
//
//  Created by FanYu on 7/19/15.
//  Copyright (c) 2015 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var label: UILabel!
    //var searchBar = UISearchBar()
    var searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        label.text = "Hello, World!"
        
        var pullDown = UISwipeGestureRecognizer(target: self, action: "pullGesture:")
        pullDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(pullDown)
        
        var pullUp = UISwipeGestureRecognizer(target: self, action: "pullGesture:")
        pullUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(pullUp)
        
        //self.searchController.searchBar = UISearchBar(frame: CGRect(x: 0, y: -40, width: self.view.frame.size.width, height: 40))
        //searchBar = UISearchBar(frame: CGRect(x: 0, y: -40, width: self.view.frame.size.width, height: 40))
        //searchBar.backgroundColor = UIColor.blackColor()
        
        self.searchController = UISearchController(searchResultsController: nil)
        //self.searchController.searchBar.frame = CGRect(x: 0, y: -40, width: self.view.frame.size.width, height: 40)
        self.searchController.searchBar.delegate = self
        //self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.searchBar.showsCancelButton = true
        
        self.view.addSubview(self.searchController.searchBar)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.searchController.searchBar.frame = CGRectMake(0, -40, self.view.frame.width, 40)
            }, completion: { (Bool) -> Void in
        })

    }
    
    func pullGesture(gesture: UISwipeGestureRecognizer) {
        
        if gesture.direction == UISwipeGestureRecognizerDirection.Down {
            println("pull down")
//            UIView.animateWithDuration(0.1, animations: { () -> Void in
//                self.searchController.searchBar.frame = CGRectMake(0, 20, self.view.frame.width, 40)
//                }, completion: { (Bool) -> Void in
//            })
            //searchController.searchBar.becomeFirstResponder()
            //self.searchController.active = true
            var searchView = self.storyboard?.instantiateViewControllerWithIdentifier("SearchView") as! SearchViewController
            //self.navigationController?.pushViewController(tableView, animated: true)

            self.presentViewController(searchView, animated: false, completion: nil)
        }
        
        if gesture.direction == UISwipeGestureRecognizerDirection.Up {
            println("pull Up")
//            UIView.animateWithDuration(0.1, animations: { () -> Void in
//                self.searchController.searchBar.frame = CGRectMake(0, -40, self.view.frame.width, 40)
//                }, completion: { (Bool) -> Void in
//            })
            //self.presentingViewController?.dismissViewControllerAnimated(false, completion: nil)
        }
        
    }
    
    
    // MARK: - Animation transition
//    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return transition
//    }
}
