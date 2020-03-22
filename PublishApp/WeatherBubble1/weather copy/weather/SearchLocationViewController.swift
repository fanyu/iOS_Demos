//
//  SearchLocationTableViewController.swift
//  
//
//  Created by FanYu on 6/18/15.
//
//

import UIKit
import Foundation

// coorespond components position of countries list in array
struct cPositions {
    static let ID = 0
    static let City = 1
    static let Country = 4
}

struct CityDetail {
    var city = ""
    var country = ""
    var idCity = -1
}

class SearchLocationViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    var data = [CityDetail]()           // database data
    var filteredData = [CityDetail]()   // show after searching
    var resultSearchController = UISearchController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor.blackColor()
        
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.searchBarStyle = .Minimal
            controller.searchBar.barTintColor = UIColor.blueColor()
            controller.searchBar.delegate = self
            controller.searchBar.showsCancelButton = true
            controller.searchBar.placeholder = "请输入城市拼音"
            controller.searchBar.barStyle = UIBarStyle.Black
            controller.searchBar.keyboardAppearance = UIKeyboardAppearance.Dark
            
            // show searchBar ahead the tableView
            self.tableView.tableHeaderView = controller.searchBar
            controller.active = true
            
            return controller
        })()

        // async get country list from the database
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let path = NSBundle.mainBundle().pathForResource("countries", ofType: "txt")
            if let content = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil) {
                // parsing file 
                var temp = content.componentsSeparatedByString("\n")
                temp.removeAtIndex(0)   // remove the title 
                for line in temp {
                    let lineArray = line.componentsSeparatedByString("\t")
                    self.data.append(CityDetail(city   : lineArray[cPositions.City],
                                                country: lineArray[cPositions.Country],
                                                idCity : lineArray[cPositions.ID].toInt()!))
                }
            }
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
                //self.resultSearchController.active = true
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Table view protocol
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let record = self.resultSearchController.active ? filteredData[indexPath.row] : data[indexPath.row]
        SavedCity.insertCity(record.city, country: record.country, idCity: record.idCity)
        
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // active to show filteredData which is less than data
        if resultSearchController.active {
            return filteredData.count
        } else {
            return data.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell {
        let c = tableView.dequeueReusableCellWithIdentifier("SearchLocationCell") as! UITableViewCell
        c.textLabel?.textColor = UIColor.whiteColor()
        
        if (self.resultSearchController.active) {
            let record =  filteredData[indexPath.row]
            c.textLabel?.text = record.city + ", " + record.country
        } else {
            let record =  data[indexPath.row]
            c.textLabel!.text = record.city + ", " + record.city
        }
        
        return c
    }

    
    func filterContentForSearchText(searchText: String) {
        // Filter the array using the filter method
        filteredData = data.filter() { (line: CityDetail) -> Bool in
            return line.city.lowercaseString.rangeOfString(searchText) != nil
        }
    }
    // MARK: - Search
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filteredData.removeAll(keepCapacity: false)
        filterContentForSearchText(searchController.searchBar.text.lowercaseString)
        self.tableView.reloadData()
    }

}
