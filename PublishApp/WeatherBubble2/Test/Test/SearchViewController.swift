//
//  TableViewController.swift
//  
//
//  Created by FanYu on 7/21/15.
//
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    var searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40)
        self.searchController.searchBar.delegate = self
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.searchBar.showsCancelButton = true
        
        self.tableView.tableHeaderView = searchController.searchBar
        //self.tableView.contentOffset = CGPointMake(0, 40)
        //self.searchController.searchBar.becomeFirstResponder()
        self.view.addSubview(self.searchController.searchBar)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func viewDidAppear(animated: Bool) {
//        self.searchController.searchBar.becomeFirstResponder()
//    }
    
//    override func viewDidLayoutSubviews() {
//        self.searchController.searchBar.becomeFirstResponder()
//    }
    
    
//    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
//        //println("End Dece")
//        println("\(scrollView.contentOffset.y)")
//        if scrollView.contentOffset.y == 0 {
//            searchController.searchBar.becomeFirstResponder()
//            println("<0")
//        }
//        //println("\(scrollView.contentInset)")
//        
//    }
    
    // fix the search bar, do not move when scrolling
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        self.searchController.searchBar.frame.origin.y = min(0, scrollView.contentOffset.y)
//    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate {
            //searchController.searchBar.becomeFirstResponder()
            searchController.searchBar.resignFirstResponder()

        }
        println("ddddd")
        if scrollView.contentOffset.y < 22 {
            println("Down")
//            UIView.animateWithDuration(0.1, animations: { () -> Void in
//                self.searchController.searchBar.frame = CGRectMake(0, 0, self.view.frame.width, 40)
//                }, completion: { (Bool) -> Void in
//            })
            //searchController.searchBar.becomeFirstResponder()
        } else {
            println("Up")
//            UIView.animateWithDuration(0.1, animations: { () -> Void in
//                self.searchController.searchBar.frame = CGRectMake(0, -50, self.view.frame.width, 40)
//                }, completion: { (Bool) -> Void in
//            })
            self.presentingViewController?.dismissViewControllerAnimated(false, completion: nil)
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        presentingViewController?.dismissViewControllerAnimated(false, completion: nil)
//        UIView.animateWithDuration(0.1, animations: { () -> Void in
//            self.searchController.searchBar.frame = CGRectMake(0, -50, self.view.frame.width, 40)
//            }, completion: { (Bool) -> Void in
//        })
        //self.tableView.contentOffset = CGPointMake(0, 40)
        
    }
    

    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 5
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 1
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchCell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        //cell.textLabel?.text = "JJJJ"
        //cell.textLabel?.textAlignment = NSTextAlignment.Center
        cell.backgroundColor = UIColor.blueColor()
        
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
