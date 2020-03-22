//
//  PhotoBrowserCollectionViewController.swift
//  Photomania
//
//  Created by Essan Parto on 2014-08-20.
//  Copyright (c) 2014 Essan Parto. All rights reserved.
//

import UIKit
import Alamofire


class PhotoBrowserCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  var photos = NSMutableOrderedSet()
  
  let refreshControl = UIRefreshControl()
    
  var populatingPhotos = false
  var currentPage = 1
    
  let PhotoBrowserCellIdentifier = "PhotoBrowserCell"
  let PhotoBrowserFooterViewIdentifier = "PhotoBrowserFooterView"
  
  let imageCache = NSCache()
    
  // MARK: Life-cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    
    populatePhotos()
    
    // Alamofire
//    Alamofire.request(.GET, "https://api.500px.com/v1/photos", parameters:
//        ["consumer_key": "3k1zcQxFS4S7nOmTXzmH0nw3zBjOTuOIZ1hCbrgN"]).responseJSON() {
//        response in
//        // get json
//        guard let JSON = response.result.value else { return }
//        // get photo json
//        guard let photoJsons = JSON.valueForKey("photos") as? [NSDictionary] else { return }
//        // get photo id url
//        photoJsons.forEach {
//            guard let nsfw = $0["nsfw"] as? Bool,
//                  let id = $0["id"] as? Int,
//                  let url = $0["image_url"] as? String
//                  where  nsfw == false else {return}
//            self.photos.addObject(PhotoInfo(id: id, url: url))
//        }
//        // reload data
//        self.collectionView?.reloadData()
//    }
    
}

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
    
    
  // MARK: CollectionView
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photos.count
  }
  
    
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PhotoBrowserCellIdentifier, forIndexPath: indexPath) as! PhotoBrowserCollectionViewCell
    
    let imageURL = (photos.objectAtIndex(indexPath.row) as! PhotoInfo).url
    // since it's reused cell, so not show former image
    
    // 1
    cell.request?.cancel()
    
    // 2
    if let image = self.imageCache.objectForKey(imageURL) as? UIImage {
        cell.imageView.image = image
    } else {
        // 3
        cell.imageView.image = nil
        
        // 4
        cell.request = Alamofire.request(.GET, imageURL).validate(contentType: ["image/*"]).responseImage() {
            response in
            guard let image = response.result.value where response.result.error == nil else { return }
            // 5
            self.imageCache.setObject(image!, forKey: response.request!.URLString)
            
            // 6
            cell.imageView.image = image
        }
        /*
        如果单元格在图片下载完成之前离开了屏幕，那么我们将暂停下载，并且返回一个NSURLErrorDomain (-999: cancelled)对象。这是业界普遍的处理方式。
        */
    }
    return cell
  }
  
    
    
  override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
    return collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: PhotoBrowserFooterViewIdentifier, forIndexPath: indexPath) as! UICollectionReusableView
  }
  
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    performSegueWithIdentifier("ShowPhoto", sender: (self.photos.objectAtIndex(indexPath.item) as! PhotoInfo).id)
  }
  
  // MARK: Helper
  
  func setupView() {
    navigationController?.setNavigationBarHidden(false, animated: true)
    
    // collection view layout
    let layout = UICollectionViewFlowLayout()
    let itemWidth = (view.bounds.size.width - 2) / 3
    layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
    layout.minimumInteritemSpacing = 1.0
    layout.minimumLineSpacing = 1.0
    layout.footerReferenceSize = CGSize(width: collectionView!.bounds.size.width, height: 100.0)
    
    collectionView!.collectionViewLayout = layout
    
    
    // navigation
    navigationItem.title = "Featured"
    
    // register class
    collectionView!.registerClass(PhotoBrowserCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: PhotoBrowserCellIdentifier)
    collectionView!.registerClass(PhotoBrowserCollectionViewLoadingCell.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: PhotoBrowserFooterViewIdentifier)
    
    // refresh controller
    refreshControl.tintColor = UIColor.whiteColor()
    refreshControl.addTarget(self, action: "handleRefresh", forControlEvents: .ValueChanged)
    collectionView!.addSubview(refreshControl)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowPhoto" {
      (segue.destinationViewController as! PhotoViewerViewController).photoID = sender!.integerValue
      (segue.destinationViewController as! PhotoViewerViewController).hidesBottomBarWhenPushed = true
    }
  }
  
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        // 当滚动超过80%的页面，则会加载更多图片
        if scrollView.contentOffset.y + view.frame.size.height > scrollView.contentSize.height * 0.8 {
            populatePhotos()
        }
    }

    
    // update photos
    func populatePhotos() {
        // 防止还在加载的时候，进入下一次加载页面
        if populatingPhotos {
            return
        }
        
        self.populatingPhotos = true
        
        Alamofire.request(Five100px.Router.PopularPhotos(self.currentPage)).responseJSON() {
            response in
            
            func failed() { self.populatingPhotos = false }
            guard let JSON = response.result.value else { failed(); return }
            if response.result.error != nil { failed(); return }
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
                let lastItem = self.photos.count
                
                guard let PhotoJSON = JSON.valueForKey("photos") as? [NSDictionary] else { return }
                PhotoJSON.forEach {
                    guard let nsfw = $0["nsfw"] as? Bool,
                          let id = $0["id"] as? Int,
                          let url = $0["image_u}rl"] as? String
                          where nsfw == false else { return }
                    
                    self.photos.addObject(PhotoInfo(id: id, url: url))
                }
                
                let indexPaths = (lastItem ..< self.photos.count).map { NSIndexPath(forItem: $0, inSection: 0) }
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.collectionView!.insertItemsAtIndexPaths(indexPaths)
                }
                
                self.currentPage++
            }
        }
        self.populatingPhotos = false
    }
    
    func handleRefresh() {
    
    }
}


// Cell
class PhotoBrowserCollectionViewCell: UICollectionViewCell {
  let imageView = UIImageView()
  
    var request: Alamofire.Request?
    
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = UIColor(white: 0.1, alpha: 1.0)
    
    imageView.frame = bounds
    addSubview(imageView)
  }
}

// Header
class PhotoBrowserCollectionViewLoadingCell: UICollectionReusableView {
  let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    spinner.startAnimating()
    spinner.center = self.center
    addSubview(spinner)
  }
}

