//
//  FetchCollectionViewController.swift
//  PhotoFromSystem
//
//  Created by FanYu on 20/1/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit
import Photos
import PhotosUI // live photo

private let reuseIdentifier = "Cell"

class FetchCollectionViewController: UIViewController {

    // asset
    var assetsFetchResults = PHFetchResult()
    var assetCollection = PHAssetCollection()
    var assetThumbnailSize = CGSize()
    
    // manager 
    var imgManager = PHCachingImageManager()
    var previousPreheatRect = CGRect()
    
    // collection
    var collectionView: UICollectionView!
    var collectionCell = UICollectionViewCell()
    
    // button
    var addButton: UIBarButtonItem!
    
    // MARK: - Life Scycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        resetCachedAssets()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // avoid 失真
        let scale = UIScreen.mainScreen().scale
        assetThumbnailSize = CGSizeMake(80 * scale, 80 * scale)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.updateCachedAssets()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setup() {
        // self 
        self.view.backgroundColor = UIColor(red:0.02, green:0.6, blue:0.99, alpha:1)
        
        // layout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .Vertical
        
        // colleciton
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        collectionView.center = self.view.center
        collectionView.backgroundColor = UIColor.redColor()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.registerClass(CollectionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        view.addSubview(collectionView)
    }
}


// MARK: - Scroll 
// 
extension FetchCollectionViewController {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.updateCachedAssets()
    }
}


// MARK: - CollectionView DataSource
//
extension FetchCollectionViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.assetsFetchResults.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // asset
        let asset = self.assetsFetchResults[indexPath.item]
        
        // cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionCell
        cell.backgroundColor = UIColor.whiteColor()
        cell.representedAssetIdentifier = asset.localIdentifier
        
        // live photot badge
        if asset.mediaSubtypes == PHAssetMediaSubtype.PhotoLive {
            let badge = PHLivePhotoView.livePhotoBadgeImageWithOptions(.OverContent)
            cell.livePhotoBadge.image = badge
        }
        
        // get image and assign
        self.imgManager.requestImageForAsset(asset as! PHAsset,
            targetSize: assetThumbnailSize,
            contentMode: PHImageContentMode.AspectFill,
            options: nil) { (image, info) -> Void in
            
            // Set the cell's thumbnail image if it's still showing the same asset.
            if cell.representedAssetIdentifier.isEqualToString(asset.localIdentifier) {
                cell.layer.contents = image?.CGImage
            }
        }
        
        return cell
    }
}


// MARK: - CollectionView Delegate FlowLayout
//
extension FetchCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let vc = AssetViewController()
        vc.asset = self.assetsFetchResults[indexPath.item] as! PHAsset
        vc.assetCollection = self.assetCollection
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}



// MARK: - Asset Caching
// 可有可无，目前感觉，没什么影响啊
extension FetchCollectionViewController {
    func resetCachedAssets() {
        self.imgManager.stopCachingImagesForAllAssets()
        self.previousPreheatRect = CGRectZero
    }
    
    func updateCachedAssets() {
        guard self.view.window != nil else {
            return
        }
        
        // the preheat windwo is twice the height of the visible rect
        var preheatRect = self.collectionView.bounds
        preheatRect = CGRectInset(preheatRect, 0, -0.5 * CGRectGetHeight(preheatRect))
        
        // Check if the collection view is showing an area that is significantly different to the last preheated area.
        let delta = abs(CGRectGetMidY(preheatRect) - CGRectGetHeight(preheatRect))
        if delta > CGRectGetHeight(self.collectionView.bounds) / 3.0 {
            
            // compute the assets to start caching and to stop caching
            let addedIndexPaths = NSMutableArray()
            let removedIndexPaths = NSMutableArray()
            
            self.computeDifferenceBetweenRect(self.previousPreheatRect, newRect: preheatRect, removedHandler: { (removedRect) -> Void in
                    let indexPaths = self.collectionView.aapl_indexPathsForElementsInRect(removedRect)
                    removedIndexPaths.addObject(indexPaths)
                }, addedHandler: { (addRect) -> Void in
                    let indexPaths = self.collectionView.aapl_indexPathsForElementsInRect(addRect)
                    addedIndexPaths.addObject(indexPaths)
            })
            
            let assetsToStartCaching = self.assetsAtIndexPaths(addedIndexPaths)
            let assetsToStopCaching = self.assetsAtIndexPaths(addedIndexPaths)
            
            // Update the assets the PHCachingImageManager is caching.
            self.imgManager.startCachingImagesForAssets(assetsToStartCaching as! [PHAsset],
                targetSize: assetThumbnailSize,
                contentMode: .AspectFill,
                options: nil)
            
            self.imgManager.stopCachingImagesForAssets(assetsToStopCaching as! [PHAsset],
                targetSize: assetThumbnailSize,
                contentMode: .AspectFill,
                options: nil)

            self.previousPreheatRect = preheatRect
        }
    }
    
    func computeDifferenceBetweenRect(oldRect: CGRect, newRect: CGRect, removedHandler: CGRect -> Void, addedHandler: CGRect -> Void) {
        
        if !CGRectIntersection(newRect, oldRect).isEmpty {
            let oldMaxY = CGRectGetMaxY(oldRect)
            let oldMinY = CGRectGetMinY(oldRect)
            let newMaxY = CGRectGetMaxY(newRect)
            let newMinY = CGRectGetMinY(newRect)
            
            if newMaxY > oldMaxY {
                let rectToAdd = CGRectMake(newRect.origin.x, oldMaxY, newRect.size.width, (newMaxY - oldMaxY))
                addedHandler(rectToAdd)
            }
            
            if oldMinY > newMinY {
                let rectToAdd = CGRectMake(newRect.origin.x, newMinY, newRect.size.width, (oldMinY - newMinY))
                addedHandler(rectToAdd)
            }
            
            if newMaxY < oldMaxY {
                let rectToRemove = CGRectMake(newRect.origin.x, newMaxY, newRect.size.width, (oldMaxY - newMaxY))
                removedHandler(rectToRemove)
            }
            
            if (oldMinY < newMinY) {
                let rectToRemove = CGRectMake(newRect.origin.x, oldMinY, newRect.size.width, (newMinY - oldMinY))
                removedHandler(rectToRemove)
            }
        } else {
            addedHandler(newRect)
            removedHandler(oldRect)
        }
    }
    
    func assetsAtIndexPaths(indexPaths: NSArray) -> NSArray {
        guard indexPaths.count != 0 else {
            return NSArray()
        }
        
        let assets = NSMutableArray(capacity: indexPaths.count)
        
        for indexPath in 0 ..< indexPaths.count {
            let asset = self.assetsFetchResults[indexPath] as! PHAsset
            assets.addObject(asset)
        }
        
        return assets
    }
}


// MARK: - Cell 
//
class CollectionCell: UICollectionViewCell {
    
    var representedAssetIdentifier = NSString()
    var livePhotoBadge = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // self 
        self.backgroundColor = UIColor.greenColor()
        //self.contentMode = .ScaleAspectFit
        
        // badge 
        livePhotoBadge.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        self.addSubview(livePhotoBadge)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



// MARK: - Extension
//
extension UICollectionView {
    
    func aapl_indexPathsForElementsInRect(rect: CGRect) -> NSArray {
        let allLayoutAttributes = self.collectionViewLayout.layoutAttributesForElementsInRect(rect)
        guard allLayoutAttributes!.count != 0 else {
            return NSArray()
        }
        
        let indexPaths = NSMutableArray(capacity: (allLayoutAttributes?.count)!)
        for attribute in allLayoutAttributes! {
            let indexPath = attribute.indexPath
            indexPaths.addObject(indexPath)
        }
        return indexPaths
    }
}
