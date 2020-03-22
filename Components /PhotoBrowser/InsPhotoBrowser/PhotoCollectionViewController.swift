//
//  PhotoCollectionViewController.swift
//  PhotoBrowser
//
//  Created by FanYu on 20/10/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
private let PhotoBrowserFooterViewIdentifier = "PhotoBrowserFooterView"


class PhotoCollectionViewController: UICollectionViewController, SKPhotoBrowserDelegate {

    var photos = ["1", "2", "3", "4","1", "2", "3", "4","1", "2", "3", "4","5", "6"]
    let refreshControl = UIRefreshControl() // refresh contents
    var nextRequest = false
    var images = [SKPhoto]()
    
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.tintColor = UIColor.whiteColor()
        refreshControl.addTarget(self, action: "handleRefresh", forControlEvents: .ValueChanged)
        collectionView?.addSubview(refreshControl)
        
        for i in 0 ..< photos.count {
            let photo = SKPhoto.photoWithImage(UIImage(named: photos[i])!)
            //photo.caption = caption[i%10]
            images.append(photo)
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func didShowPhotoAtIndex(index: Int) {
        // do some handle if you need
    }
    
    func willDismissAtPageIndex(index: Int) {
        // do some handle if you need
    }
    
    func didDismissAtPageIndex(index: Int) {
        // do some handle if you need
    }


    
    // MARK: UICollectionViewDataSource
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
    
        cell.imageView.image = UIImage(named: "\(photos[indexPath.item])")
        
        return cell
    }

    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let footerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: PhotoBrowserFooterViewIdentifier, forIndexPath: indexPath) as! FooterView
        if nextRequest {
            footerView.spinner.startAnimating()
        } else {
            footerView.spinner.stopAnimating()
        }
        return footerView
    }
    
    
//    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        // let photoInfo = photos[indexPath.item]
//        //performSegueWithIdentifier("ShowPhoto", sender: ["photoInfo": photoInfo])
//        
//        self.presentViewController(PhotoViewerVC(), animated: false, completion: nil)
////        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CollectionViewCell
////        
////        let originImage = cell.imageView.image
////        let browser = SKPhotoBrowser(originImage: originImage!, photos: images, animatedFromView: cell)
////        browser.initializePageIndex(indexPath.row)
////        browser.delegate = self
////        
////        presentViewController(browser, animated: true, completion: {})
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let cell = sender as! CollectionViewCell
        
        if segue.identifier == "Showphoto" {
            let destinationVC = segue.destinationViewController as! PhotoViewerVC
            destinationVC.photo = cell.imageView.image!
        }
    }
}



// MARK: UICollectionViewDelegateFlowLayout 设置布局
extension PhotoCollectionViewController: UICollectionViewDelegateFlowLayout {

    // use the protocol
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let itemWidth = (view.bounds.size.width - 2) / 3
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    // 上下
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1
    }
    
    // 左右
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 100)
    }
}


extension PhotoCollectionViewController {
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let refreshThread = scrollView.contentOffset.y + view.frame.size.height - scrollView.contentSize.height
        guard nextRequest && refreshThread > 0  else {
            nextRequest = !nextRequest
            return
        }
    }
}

//MARK: - Helper
extension PhotoCollectionViewController {
    func handleRefresh() {
        nextRequest = false
        refreshControl.beginRefreshing()
        self.photos.removeAll(keepCapacity: false)
        self.collectionView?.reloadData()
        refreshControl.endRefreshing()
    }
}
