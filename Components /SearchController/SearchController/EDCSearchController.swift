//
//  EDCSearchController.swift
//  SearchController
//
//  Created by FanYu on 30/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit


protocol EDCSearchControllerDelegate{
    func didStartSearching()
    func didTapSearchButton()
    func didTapCancelButton()
    func didChangeSearchText(searchText: String)
}


class EDCSearchController: UISearchController, UISearchBarDelegate {

    var edcSearchBar: EDCSearchBar!
    var edcDelegate: EDCSearchControllerDelegate!
    
    init(searchResultsController: UIViewController!, searchBarFrame: CGRect, searchBarFont: UIFont, searchBarTextColor: UIColor, searchBarTintColor: UIColor) {
        super.init(searchResultsController: searchResultsController)
        
        configureSearchBar(searchBarFrame, font: searchBarFont, textColor: searchBarTextColor, backgroundColor: searchBarTintColor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func configureSearchBar(frame: CGRect, font: UIFont, textColor: UIColor, backgroundColor: UIColor) {
        edcSearchBar = EDCSearchBar(frame: frame, font: font, textColor: textColor)
        
        edcSearchBar.barTintColor = backgroundColor
        edcSearchBar.tintColor = textColor
        edcSearchBar.showsBookmarkButton = false
        edcSearchBar.showsCancelButton = true
        
        edcSearchBar.delegate = self
    }
    
    // begin editing
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        edcDelegate.didStartSearching()
    }
    
    // search button clicked
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        edcSearchBar.resignFirstResponder()
        edcDelegate.didTapSearchButton()
    }
    
    // cancel button clicked
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        edcSearchBar.resignFirstResponder()
        edcDelegate.didTapCancelButton()
    }
    
    // search text
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        edcDelegate.didChangeSearchText(searchText)
    }
    
}
