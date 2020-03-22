//
//  SearchViewController.swift
//  
//
//  Created by FanYu on 7/22/15.
//
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {

    @IBOutlet weak var tableView: UITableView!
    var searchController = UISearchController()
    
    var countryData = [CityDetail]()       // database data
    var filteredData = [CityDetail]()   // show after searching
    var textDidChanged = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(red: 20.0 / 255.0, green: 20.0 / 255.0, blue: 20.0 / 255.0, alpha: 1.0)
        
        // search bar 
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40)
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
        self.searchController.delegate = self
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        
        self.searchController.searchBar.barStyle = UIBarStyle.Black
        //self.searchController.searchBar.tintColor = UIColor.whiteColor() // button color
        self.searchController.searchBar.barTintColor = UIColor(red: 67.0 / 255.0, green: 67.0 / 255.0, blue: 67.0 / 255.0, alpha: 1.0)
        
        self.searchController.searchBar.placeholder = "请输入城市名的拼音"
        self.searchController.searchBar.keyboardAppearance = UIKeyboardAppearance.Dark
    
        self.definesPresentationContext = true
        self.searchController.searchBar.sizeToFit()
        self.view.addSubview(self.searchController.searchBar)
        
        asyncGetCountryList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Show key board
    override func viewDidAppear(animated: Bool) {
        self.searchController.active = true
    }
    
    func didPresentSearchController(searchController: UISearchController) {
        self.searchController.searchBar.becomeFirstResponder()
        self.searchController.becomeFirstResponder()
    }


    
    // MARK: - Get country list from database 
    func asyncGetCountryList() {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let path = NSBundle.mainBundle().pathForResource("countries", ofType: "txt")
            if let content = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil) {
                //parsing file
                var temp = content.componentsSeparatedByString("\n")
                temp.removeAtIndex(0)
                for line in temp {
                    let lineArray = line.componentsSeparatedByString("\t")
                    self.countryData.append(CityDetail(city   : lineArray[CityListInfo.City],
                                                       country: lineArray[CityListInfo.Country],
                                                       id     : lineArray[CityListInfo.ID].toInt()!))
                }
            }
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        }
        
        //var time = dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC)
        //dispatch_apply(<#iterations: Int#>, <#queue: dispatch_queue_t!#>, <#block: (Int) -> Void##(Int) -> Void#>)
        //NSBlockOperation
    }
    
    
    
    
    // MARK: - UISearch Controller Delegate change barbutton title
    func willPresentSearchController(searchController: UISearchController) {
        searchController.searchBar.showsCancelButton = true
        for subview in searchController.searchBar.subviews[0].subviews {
            if subview.isKindOfClass(UIButton) {
                var cancleButton = subview as! UIButton
                cancleButton.setTitle("返回", forState: UIControlState.Normal)
            }
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.presentingViewController?.dismissViewControllerAnimated(false, completion: nil)
    }
    
    
    // MARK: - Table View DataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchCell", forIndexPath: indexPath) as! UITableViewCell
        
        // set selected cell color
        let selectedView = UIView(frame: cell.frame)
        selectedView.backgroundColor = UIColor(red: 42.0 / 255.0, green: 127.0 / 255.0, blue: 254.0 / 255.0, alpha: 1.0)
        cell.selectedBackgroundView = selectedView
        
        // Configure the cell
        if self.searchController.active {
            cell.textLabel?.textColor = UIColor.lightTextColor()
            cell.backgroundColor = UIColor(red: 38.0 / 255.0, green: 38.0 / 255.0, blue: 38.0 / 255.0, alpha: 1.0)
            
            let record = filteredData[indexPath.row]
            cell.textLabel?.text = record.city + ", " + record.country
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let record = self.searchController.active ? filteredData[indexPath.row] : countryData[indexPath.row]
        SavedCity.insertCity(record.city, country: record.country, id: record.id)
        
        self.presentingViewController?.dismissViewControllerAnimated(false, completion: nil)
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !textDidChanged {
            if scrollView.contentOffset.y > 0 { // up scroll
                self.presentingViewController?.dismissViewControllerAnimated(false, completion: nil)
            } else {
                self.searchController.searchBar.becomeFirstResponder()
            }
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.textDidChanged = true
    }
    
    // MARK: - Search Results Updating
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text.lowercaseString)
        self.tableView.reloadData()
    }
        
    //Helper functions
    func filterContentForSearchText(searchText: String) {
        self.filteredData = self.countryData.filter({(line: CityDetail) -> Bool in
            return line.city.lowercaseString.rangeOfString(searchText, options: nil, range: nil, locale: nil) != nil
        })
    }
    
}
