//
//  MyCollectionViewController.swift
//  
//
//  Created by FanYu on 9/12/15.
//
//

import UIKit

let reuseIdentifier = "Cell"

class MyCollectionViewController: UICollectionViewController {

    let photos = Album.allPhotos()
    let colors = UIColor.colorPalette()
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 头尾留白 50
        collectionView!.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 50, right: 0)
        
        // 设置 item 的大小
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: CGRectGetWidth(collectionView!.frame), height: 140)
        // item 之间的距离
        layout.minimumLineSpacing = CGFloat(2)
        // 同一行 item 之间的距离
        //layout.minimumInteritemSpacing = CGFloat(5)
        
        //println("\(collectionView!.bounds)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: UICollectionViewDataSource
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MyCollectionViewCell
    
        // Configure the cell
        // cell.contentView.backgroundColor = colors[indexPath.item]
        cell.backgroundImage.image = photos[indexPath.item]
        cell.nameLabel.text = "\(indexPath.item)"
        cell.updateParallaxOffset(collectionViewBounds: collectionView.bounds)
        return cell
    }
    
    
    
}

extension MyCollectionViewController {
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let cells = collectionView!.visibleCells()as! [MyCollectionViewCell]
        let bounds = collectionView!.bounds
        print("\(bounds)")
        for cell in cells {
            cell.updateParallaxOffset(collectionViewBounds: bounds)
        }

    }
}