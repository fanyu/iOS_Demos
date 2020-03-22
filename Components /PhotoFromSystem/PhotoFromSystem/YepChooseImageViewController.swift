//
//  YepChooseImageViewController.swift
//  PhotoFromSystem
//
//  Created by FanYu on 26/1/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit
import Photos

class YepChooseImageViewController: UIViewController {

    var width: CGFloat { return UIScreen.mainScreen().bounds.width }
    var heigth: CGFloat { return UIScreen.mainScreen().bounds.height }
    
    var showViewButton: UIButton!
    var cancleButton: UIButton!

    var contentView: UIView!
    var collectionView: UICollectionView!
    var blurView: UIView!
    
    var allPhotos: PHFetchResult!
    var imgManager: PHImageManager!
    var displayedImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        photos()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setup() {
        // self 
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.toolbar.hidden = true
        
        // show button 
        showViewButton = UIButton(frame: CGRect(x: 0, y: 0, width: 120, height: 44))
        showViewButton.center = self.view.center
        showViewButton.frame.origin.y = heigth - 200
        showViewButton.setTitle("Select Image", forState: .Normal)
        showViewButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        showViewButton.backgroundColor = UIColor.yellowColor()
        showViewButton.addTarget(self, action: #selector(YepChooseImageViewController.showViewTapped(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(showViewButton)
        
        // displayer image view 
        displayedImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        displayedImageView.center = self.view.center
        displayedImageView.frame.origin.y = 70
        displayedImageView.backgroundColor = UIColor(red:0.02, green:0.6, blue:0.99, alpha:1)
        self.view.addSubview(displayedImageView)
        
        // blure view
        blurView = UIView(frame: self.view.frame)
        blurView.backgroundColor = UIColor.blackColor()
        blurView.alpha = 0.3
        blurView.hidden = true
        //self.view.addSubview(blurView)
        self.navigationController?.view.addSubview(blurView)
        
        // blur view tapp
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(YepChooseImageViewController.blurViewTapped(_:)))
        blurView.addGestureRecognizer(tapGesture)
        
        
        // content view 
        contentView = UIView(frame: CGRect(x: 0, y: self.heigth, width: self.width, height: 300))
        contentView.backgroundColor = UIColor.whiteColor()
        //self.view.addSubview(contentView)
        self.navigationController!.view.addSubview(contentView)
        
        // layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        layout.itemSize = CGSize(width: 80, height: 80)
        
        // collection view
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: width, height: 100), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.whiteColor()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.registerClass(YepCell.self, forCellWithReuseIdentifier: "Cell")
        
        self.contentView.addSubview(collectionView)
        
        // cancle button 
        cancleButton = UIButton(frame: CGRect(x: 0, y: CGRectGetHeight(self.contentView.frame) - 44, width: self.width, height: 44))
        cancleButton.setTitle("Cancle", forState: .Normal)
        cancleButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        cancleButton.titleLabel?.textAlignment = .Center
        cancleButton.addTarget(self, action: #selector(YepChooseImageViewController.cancleTapped(_:)), forControlEvents: .TouchUpInside)
        self.contentView.addSubview(cancleButton)
    }
    
    private func photos() {
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        allPhotos = PHFetchResult()
        allPhotos = PHAsset.fetchAssetsWithOptions(allPhotosOptions)
        
        imgManager = PHImageManager()
    }
    
    func targetSize() -> CGSize {
        let scale = UIScreen.mainScreen().scale
        return CGSizeMake(80 * scale, 80 * scale)
    }
}


// MARK: - Handle Action 
// 
extension YepChooseImageViewController {
    func showViewTapped(sender: UIButton) {
        print("Show View")
        showContentView()
    }
    
    func cancleTapped(sender: UIButton) {
        print("Cancle")
        hideContentView()
    }
    
    func blurViewTapped(sender: UIButton) {
        print("Blur")
        
        hideContentView()
    }
    
    func showContentView() {
        UIView.animateWithDuration(0.5) { () -> Void in
            self.blurView.hidden = false
            self.contentView.frame.origin.y = self.heigth - CGRectGetHeight(self.contentView.frame)
        }
    }
    
    func hideContentView() {
        UIView.animateWithDuration(0.3) { () -> Void in
            self.blurView.hidden = true
            self.contentView.frame.origin.y = self.heigth
        }
    }
}


// MARK: - CollectionView DataSource
//
extension YepChooseImageViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allPhotos.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let asset = allPhotos[indexPath.item]
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! YepCell
        cell.representedAssetIdentifier = asset.localIdentifier
        
        if indexPath.item == 0 {
            print("Cell 0 ")
            cell.layer.contents = UIImage(named: "camera")?.CGImage
            
        } else {
            self.imgManager.requestImageForAsset(
                asset as! PHAsset,
                targetSize: self.targetSize(),
                contentMode: .AspectFill,
                options: nil) { (image, info) -> Void in
                    
                    if cell.representedAssetIdentifier.isEqualToString(asset.localIdentifier) {
                        cell.layer.contents = image?.CGImage
                        cell.image = image!
                    }
            }
        }
        
        return cell
    }

}


// MARK: - CollectionView Delegate FlowLayout
//
extension YepChooseImageViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Selecte")
        
        // set image
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! YepCell
        displayedImageView.image = cell.image
        
        // hide
        hideContentView()
    }
}


// MARK: - Cell 
//
class YepCell: UICollectionViewCell {
    
    var representedAssetIdentifier = NSString()
    var image = UIImage()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()//yellowColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}