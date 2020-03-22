//
//  CollectionViewController.swift
//  
//
//  Created by FanYu on 8/24/15.
//
//

import UIKit

let reuseIdentifier = "MyCollectionViewCell"

class CollectionViewController: UICollectionViewController {

    var cellImageData = ["a.png",  "b.png", "c.png", "d.png", "e.png", "f.png", "g.png", "h.png", "j.png", "k.png", "l.png", "m.png","n.png","o.png","p.png","q.png",]
    
    var imageName = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]
    
    @IBAction func editButtonTapped(sender: UIBarButtonItem) {
        
        if self.navigationItem.rightBarButtonItem?.title == "Edit" {
            self.navigationItem.rightBarButtonItem?.title = "Done"
            
            for item in self.collectionView?.visibleCells() as! [MyCollectionViewCell] {
                item.delete.hidden = false
            }
            
        } else {
            self.navigationItem.rightBarButtonItem?.title = "Edit"
            self.collectionView?.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return cellImageData.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MyCollectionViewCell
    
        // Configure the cell
        cell.label.text = cellImageData[indexPath.row].componentsSeparatedByString(".")[0].uppercaseString
        cell.image.image = UIImage(named: cellImageData[indexPath.row])
        
        // delete button
        if self.navigationItem.rightBarButtonItem!.title == "Edit" {
            cell.delete.hidden = true
        } else {
            cell.delete.hidden = false
        }
        
        cell.delete.layer.setValue(indexPath.row, forKey: "index")
        cell.delete.addTarget(self, action: "deletePhoto:", forControlEvents: UIControlEvents.TouchUpInside)
        
        return cell
    }
    
    func deletePhoto(sender: UIButton) {
        let index = sender.layer.valueForKey("index") as! Int
        cellImageData.removeAtIndex(index)
        self.collectionView?.reloadData()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! MyCollectionViewCell
        
        if segue.identifier == "ShowDetail" {
            if let destinationVC = segue.destinationViewController as? DetailViewController {
                destinationVC.detailName = cell.label.text
                destinationVC.detailImage = cell.image.image
            }
        }
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
