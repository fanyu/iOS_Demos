//
//  ViewController.swift
//  SearchController
//
//  Created by FanYu on 30/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // var
    var dataArray = [String]()
    var filteredArray = [String]()
    var shouldShowSearchResults = false
    var searchController: UISearchController!
    
    var edcSearchController: EDCSearchController!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadListOfCountries()
        //setupSearchController()
        setupEDCSearchController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be r¥ecreated.
    }
}



// MARK: - Setup
extension ViewController {
    // load data
    func loadListOfCountries() {
        let pathToFile = NSBundle.mainBundle().pathForResource("countries", ofType: "txt")
        
        if let path = pathToFile {
            let countriesString = try! String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
            dataArray = countriesString.componentsSeparatedByString("\n")
            self.tableView.reloadData()
        }
    }
    
    
    // setup
//    func setupSearchController() {
//        // Pass nil if you wish to display search results in the same view
//        searchController = UISearchController(searchResultsController: nil)
//        // delegate
//        searchController.searchResultsUpdater = self
//        searchController.searchBar.delegate = self
//        // dims back ground
//        searchController.dimsBackgroundDuringPresentation = false
//        // place holder
//        searchController.searchBar.placeholder = "Search here..."
//        // same width as table view
//        searchController.searchBar.sizeToFit()
//        
//        // place
//        tableView.tableHeaderView = searchController.searchBar
//    }
    
    // edc search controller
    func setupEDCSearchController() {
        edcSearchController = EDCSearchController(
            searchResultsController : self,
            searchBarFrame          : CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50),
            searchBarFont           : UIFont(name: "Futura", size: 16)!,
            searchBarTextColor      : UIColor.orangeColor(),
            searchBarTintColor      : UIColor.blackColor())
        
        // delegate
        edcSearchController.edcDelegate = self
        
        edcSearchController.edcSearchBar.placeholder = "Hello World"
        tableView.tableHeaderView = edcSearchController.edcSearchBar
    }
}


// MARK: - EDC Delegate
extension ViewController: EDCSearchControllerDelegate {
    func didStartSearching() {
        shouldShowSearchResults = true
        tableView.reloadData()
    }
    
    func didTapSearchButton() {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tableView.reloadData()
        }
    }
    
    func didTapCancelButton() {
        shouldShowSearchResults = false
        tableView.reloadData()
    }
    
    func didChangeSearchText(searchText: String) {
        
        filteredArray = dataArray.filter({ (country) -> Bool in
            let countryText: NSString = country
            return(countryText.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch).location != NSNotFound)
        })
        
        tableView.reloadData()
    }
}


// MARK: - Search Controller
//extension ViewController: UISearchResultsUpdating, UISearchBarDelegate {
//    
//    // MARK: - About Data
//    // update search results
//    func updateSearchResultsForSearchController(searchController: UISearchController) {
//        // get the input string
//        guard let searchString = searchController.searchBar.text else { return }
//        // filter the data
//        filteredArray = dataArray.filter({ (country) -> Bool in
//            let countryText:NSString = country
//            
//            return (countryText.rangeOfString(searchString, options: NSStringCompareOptions.CaseInsensitiveSearch).location != NSNotFound)
//        })
//        // reload
//        tableView.reloadData()
//    }
//    
//    // MARK: - About Operation
//    // show filtered data
//    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
//        self.shouldShowSearchResults = true
//        tableView.reloadData()
//    }
//    
//    // show all data
//    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
//        self.shouldShowSearchResults = false
//        tableView.reloadData()
//    }
//    
//    // search button tapped
//    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
//        if !shouldShowSearchResults {
//            self.shouldShowSearchResults = true
//            tableView.reloadData()
//        }
//        // hide button
//        searchController.searchBar.resignFirstResponder()
//    }
//}


// MARK: - TableView
extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults {
            return filteredArray.count
        } else {
            return dataArray.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        if shouldShowSearchResults {
            cell.textLabel?.text = filteredArray[indexPath.row]
        } else {
            cell.textLabel?.text = dataArray[indexPath.row]
        }
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
}

