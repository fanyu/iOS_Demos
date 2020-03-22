//
//  CollectionViewController.swift
//  
//
//  Created by FanYu on 9/8/15.
//
//

import UIKit


class CollectionViewController: UICollectionViewController {

    let albums = Album.allAlbums()
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set item size
        let width = collectionView!.bounds.size.width
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = CGSize(width: width, height: width + 60)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    // MARK: UICollectionViewDataSource
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return albums.count
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums[section].photos.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CellView
    
        // Configure the cell
        cell.photo = albums[indexPath.section].photos[indexPath.item]
        cell.likesNum = Int(arc4random_uniform(1000))
        return cell
    }

    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "Header", forIndexPath: indexPath) as! HeaderView
        
        header.album = albums[indexPath.section]
        header.timelapse = indexPath.section * 6 + Int(arc4random_uniform(8))
        return header 
    }

}
