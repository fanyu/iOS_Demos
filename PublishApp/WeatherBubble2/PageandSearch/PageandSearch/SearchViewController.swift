//
//  SearchViewController.swift
//  
//
//  Created by FanYu on 7/22/15.
//
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    var searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // table view
        tableView.delegate = self
        tableView.dataSource = self
        
        // search bar 
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40)
        self.searchController.searchBar.delegate = self
        self.searchController.delegate = self
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.searchBar.showsCancelButton = true
        
        //self.searchController.becomeFirstResponder()
        //self.searchController.searchBar.becomeFirstResponder()
        //self.searchController.becomeFirstResponder()
        //self.searchController.active = true
        
        self.view.addSubview(self.searchController.searchBar)
    
    }
    
    override func viewDidAppear(animated: Bool) {
        self.searchController.active = true
        self.searchController.searchBar.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.presentingViewController?.dismissViewControllerAnimated(false, completion: nil)
    }
    
    
    // MARK: - table view data source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchCell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.backgroundColor = UIColor.greenColor()
                
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //self.searchController.searchBar.canResignFirstResponder()
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > 0 {
            self.presentingViewController?.dismissViewControllerAnimated(false, completion: nil)
        } else {
            self.searchController.searchBar.becomeFirstResponder()
        }
    }
    
}
