//
//  FectchPhotosViewController.swift
//  PhotoFromSystem
//
//  Created by FanYu on 20/1/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit
import Photos


class FectchPhotosViewController: UIViewController {
    
    // image view 
    let imgView1 = UIImageView()
    let imgView2 = UIImageView()
    
    // fetch
    var images: NSMutableArray!
    var totoalImageCountNeeded: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        fetchPhotosQueue()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setup() {
        // self
        self.view.backgroundColor = UIColor(red:0.02, green:0.6, blue:0.99, alpha:1)
        
        // image view 
        imgView1.frame = CGRect(x: 0, y: 100, width: 100, height: 100)
        imgView1.backgroundColor = UIColor.redColor()
        
        imgView2.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        imgView2.backgroundColor = UIColor.yellowColor()
        
        view.addSubview(imgView1)
        view.addSubview(imgView2)
    }
}


// MARK: - Fetch photos 
extension FectchPhotosViewController {
    
    func fetchPhotosQueue() {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            self.fetchPhotos()
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.assignPhotos()
                print("Assign Photo")
            })
        }
    }
    
    func assignPhotos() {
        imgView1.image = images[0] as? UIImage
        imgView2.image = images[1] as? UIImage
    }
    
    func fetchPhotos() {
        images = NSMutableArray()
        totoalImageCountNeeded = 2
        self.fetchPhotoAtindexFromEnd(0)
    }
    
    func fetchPhotoAtindexFromEnd(index: Int) {
        // mamager
        let imgManager = PHImageManager.defaultManager()
        //let cachingImgManager = PHCachingImageManager()
        
        // options
        let requestOptions = PHImageRequestOptions()
        let fetchOptions = PHFetchOptions()
        
        // request options: true- only thumbnail | false- thumbnail and image
        requestOptions.synchronous = true
        
        // fetch options
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        
        // fetch result using PHAsset
        if let fetchResult: PHFetchResult = PHAsset.fetchAssetsWithMediaType(.Image, options: fetchOptions) {
            
            let allPhotos = PHAsset.fetchAssetsWithOptions(fetchOptions)
            let smartAlbums = PHAssetCollection.fetchAssetCollectionsWithType(PHAssetCollectionType.SmartAlbum, subtype: PHAssetCollectionSubtype.AlbumRegular, options: nil)
            let topLevelUserCollections = PHCollectionList.fetchTopLevelUserCollectionsWithOptions(nil)
            
            print("allPhotos\(allPhotos) \n smartAlbums:\(smartAlbums) \n top:\(topLevelUserCollections)")
            
            //print("Count : \(fetchResult.count)")
            
            // result isn't empty
            if fetchResult.count > 0 {
                
                // default manager
                imgManager.requestImageForAsset(
                    fetchResult.objectAtIndex(fetchResult.count - 1 - index) as! PHAsset,
                    targetSize      : CGSize(width: 100, height: 100),
                    contentMode     : PHImageContentMode.AspectFill,
                    options         : requestOptions,
                    resultHandler   : { (image, _: [NSObject : AnyObject]?) -> Void in
                        
                        // add returned image 
                        self.images.addObject(image!)
                        
                        // If you haven't already reached the first
                        // index of the fetch result and if you haven't
                        // already stored all of the images you need,
                        // perform the fetch request again with an
                        // incremented index
                        if index + 1 < fetchResult.count && self.images.count < self.totoalImageCountNeeded {
                            self.fetchPhotoAtindexFromEnd(index + 1)
                        } else {
                            print("final image count : \(self.images.count)")
                        }
                })
            }
        }
    }
}

