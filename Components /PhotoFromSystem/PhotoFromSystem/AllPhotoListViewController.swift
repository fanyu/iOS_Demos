//
//  AllPhotoListViewController.swift
//  PhotoFromSystem
//
//  Created by FanYu on 21/1/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit
import Photos

class AllPhotoListViewController: UIViewController {

    // table
    var tableView = UITableView()
    
    // array data
    var fetchResults = NSArray()
    var sectionTitles = NSArray()
    
    // button
    var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        photos()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        PHPhotoLibrary.sharedPhotoLibrary().unregisterChangeObserver(self)
    }
    
    private func setup() {
        // self 
        
        // tableview 
        tableView.frame = self.view.frame
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerClass(Cell.self, forCellReuseIdentifier: "AllPhotosCell")
        
        view.addSubview(tableView)
        
        // bar button
        addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(AllPhotoListViewController.addBtTapped(_:)))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    private func photos() {
        
        // options
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        // list result
        
        // all photos: all of the photos  
        let allPhotos = PHAsset.fetchAssetsWithOptions(allPhotosOptions)
        
        // albums: the list of albums
        let smartAblums = PHAssetCollection.fetchAssetCollectionsWithType(.SmartAlbum, subtype: .AlbumRegular, options: nil)
        
        // customer albums
        let topLevelUserCollections = PHCollectionList.fetchTopLevelUserCollectionsWithOptions(nil)
        
        // set arrary
        self.fetchResults = [allPhotos, smartAblums, topLevelUserCollections]
        self.sectionTitles = ["All", NSLocalizedString("Smart Albums", comment: ""), NSLocalizedString("Albums", comment: "")]
        
        // observer
        PHPhotoLibrary.sharedPhotoLibrary().registerChangeObserver(self)
    }
}


// MARK: - Handler
//
extension AllPhotoListViewController {
    func addBtTapped(sender: UIBarButtonItem) {
        // alert controller
        let alertController = UIAlertController(title: NSLocalizedString("New Album", comment: ""), message: nil, preferredStyle: .Alert)
        
        // input text field
        alertController.addTextFieldWithConfigurationHandler { (UITextField) -> Void in
            UITextField.placeholder = NSLocalizedString("Album Name", comment: "")
        }
        
        // cancel action
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .Cancel, handler: nil))
        
        // create action
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Create", comment: ""), style: .Default, handler: { (UIAlertAction) -> Void in
            
            // get the input and make sure not nil
            let testField = alertController.textFields?.first
            guard let title = testField?.text else {
                return
            }
            
            // perform albums change
            PHPhotoLibrary.sharedPhotoLibrary().performChanges({ () -> Void in
                
                PHAssetCollectionChangeRequest.creationRequestForAssetCollectionWithTitle(title)
                
                }, completionHandler: { (success, error) -> Void in
                
                    if !success {
                        print("Error creating album \(error)")
                    }
            })
        }))
        
        // present vc
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}


// MARK: - PHPhotoLibraryChangeObserver
//
extension AllPhotoListViewController: PHPhotoLibraryChangeObserver {
    
    func photoLibraryDidChange(changeInstance: PHChange) {
    
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            
            // get original result
            let updatedFetchResults = self.fetchResults.mutableCopy()
            var reloadRequired = false
            
            // changes
            self.fetchResults.enumerateObjectsUsingBlock({ (object, index, stop) -> Void in
                let changeDetails = changeInstance.changeDetailsForFetchResult(object as! PHFetchResult)
                
                if changeDetails != nil {
                    updatedFetchResults.replaceObjectAtIndex(index, withObject: (changeDetails?.fetchResultAfterChanges)!)
                    reloadRequired = true
                }
            })
            
            if reloadRequired {
                self.fetchResults = updatedFetchResults as! NSArray
                self.tableView.reloadData()
            }
        }
    }
}



// MARK: - TableView Data Source
//
extension AllPhotoListViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fetchResults.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 0
        
        if section == 0 {
            numberOfRows = 1
        } else {
            numberOfRows = self.fetchResults[section].count
        }
        
        return numberOfRows
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("AllPhotosCell", forIndexPath: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = NSLocalizedString("All Photos", comment: "")
            
        } else {
            // current section data
            let result = self.fetchResults[indexPath.section] //as! NSArray
            //let collection = result[indexPath.row]
            
            //cell.textLabel?.text = collection.localizedTitle
        }
        
        return cell 
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionTitles[section] as? String
    }
}

// MARK: - TableView Delegate
// 
extension AllPhotoListViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // selected cell
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        // destination view controller
        let collectionViewController = FetchCollectionViewController()
        collectionViewController.title = cell?.textLabel?.text
        
        // current section data
        let fetchResult = self.fetchResults[indexPath.section] as! NSArray

        // all photos
        if cell?.textLabel?.text == "All Photos" {
            collectionViewController.assetsFetchResults = fetchResult as! PHFetchResult
        }
        // smart albums
        else {
            // first, get one album collection
            let assetCollection = fetchResult[indexPath.row] as! PHAssetCollection
            // second, get result through specific album collection
            let assetsFetchResult = PHAsset.fetchAssetsInAssetCollection(assetCollection, options: nil)
            
            collectionViewController.assetCollection = assetCollection
            collectionViewController.assetsFetchResults = assetsFetchResult
        }
        
        // push
        self.navigationController?.pushViewController(collectionViewController, animated: true)
    }
    
}

// MARK: - Cell 
//
class Cell: UITableViewCell {
    
    var representedAssetIdentifier = NSString()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .None
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}