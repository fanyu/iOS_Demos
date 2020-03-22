//
//  AssetViewController.swift
//  PhotoFromSystem
//
//  Created by FanYu on 22/1/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit
import PhotosUI
import Photos

class AssetViewController: UIViewController {

    // view
    var livePhotoView: PHLivePhotoView!
    var imageView: UIImageView!
    
    // button
    var editButton: UIBarButtonItem!
    var processView: UIProgressView!
    var playButton: UIBarButtonItem!
    var space: UIBarButtonItem!
    var transhButton: UIBarButtonItem!
    
    // player 
    var playerLayer = AVPlayerLayer()
    var lastTargetSize = CGSize()
    var playingHint = true
    
    // asset 
    var asset = PHAsset()
    var assetCollection = PHAssetCollection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        PHPhotoLibrary.sharedPhotoLibrary().unregisterChangeObserver(self)
    }
    
    override func viewWillAppear(animated: Bool) {
        
        // toolbar
        if self.asset.mediaType == PHAssetMediaType.Video {
            self.showPlaybackToobar()
        } else {
            self.showStaticToolbar()
        }
        
        // edit button
        self.editButton.enabled = self.asset.canPerformEditOperation(.Properties) || self.asset.canPerformEditOperation(.Content)
        
        // trash button
//        var isTrashable = false
//        if self.assetCollection.estimatedAssetCount != 0  {
//            isTrashable = self.assetCollection.canPerformEditOperation(.RemoveContent)
//        } else {
//            isTrashable = self.assetCollection.canPerformEditOperation(.Delete)
//        }
        self.transhButton.enabled = true//isTrashable
        
        // update image
        self.updateImage()
        
        // update layout
        self.view.layoutIfNeeded()
    }
    
    func setup() {
        // self 
        self.view.backgroundColor = UIColor.whiteColor()
        
        // imageView 
        imageView = UIImageView(frame: self.view.frame)
        imageView.center = self.view.center
        imageView.contentMode = .ScaleAspectFit
        imageView.backgroundColor = UIColor.redColor()
        self.view.addSubview(imageView)
        
        // livePhoto View 
        livePhotoView = PHLivePhotoView(frame: self.view.frame)
        livePhotoView.center = self.view.center
        livePhotoView.contentMode = .ScaleAspectFit
        livePhotoView.backgroundColor = UIColor.yellowColor()
        livePhotoView.delegate = self
        self.view.addSubview(livePhotoView)
        
        // observer
        PHPhotoLibrary.sharedPhotoLibrary().registerChangeObserver(self)
        
        // edit button 
        editButton = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: #selector(AssetViewController.editTapped(_:)))
        self.navigationItem.rightBarButtonItem = editButton
        
        // space button
        space = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil)
        
        // play Button
        playButton = UIBarButtonItem(barButtonSystemItem: .Play, target: self, action: #selector(AssetViewController.playTapped(_:)))
        
        // trash button 
        transhButton = UIBarButtonItem(barButtonSystemItem: .Trash, target: self, action: #selector(AssetViewController.transhTapped(_:)))
    }
    
    func showLivePhotoView() {
        self.livePhotoView.hidden = false
        self.imageView.hidden = true
    }
    
    func showStaticPhotoView() {
        self.livePhotoView.hidden = true
        self.imageView.hidden = false
    }
    
    func showPlaybackToobar() {
        self.toolbarItems = [self.playButton, self.space, self.transhButton]
    }
    
    func showStaticToolbar() {
        self.toolbarItems = [self.space, self.transhButton]
    }
    
    func targetSize() -> CGSize {
        let scale = UIScreen.mainScreen().scale
        let targetSzie = CGSizeMake(CGRectGetWidth(self.imageView.bounds) * scale, CGRectGetHeight(self.imageView.bounds) * scale)
        //print("\(scale) \(targetSzie)")
        
        return targetSzie
    }
    
    func updateImage() {
        self.lastTargetSize = self.targetSize()
        
        // is a live photo
        if self.asset.mediaSubtypes == PHAssetMediaSubtype.PhotoLive {
            self.updateLiveImage()
        } else {
            self.updateStaticImage()
        }
    }
    
    func updateLiveImage() {
        // live photo options
        let livePhotoOptions = PHLivePhotoRequestOptions()
        livePhotoOptions.deliveryMode = .HighQualityFormat
        livePhotoOptions.networkAccessAllowed = true
        livePhotoOptions.progressHandler = {
            (progress   : Double,
            error       : NSError?,
            stop        : UnsafeMutablePointer<ObjCBool>,
            info        : [NSObject : AnyObject]?) in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.processView.progress = Float(progress)
            })
        }
        
        // get photo
        PHImageManager.defaultManager().requestLivePhotoForAsset(self.asset,
            targetSize: self.targetSize(),
            contentMode: .AspectFit,
            options: livePhotoOptions) { (livePhoto, info) -> Void in
            
            guard (livePhoto != nil) else {
                return
            }
            
            print("Got a live Photo")
            
            // show the live photo view and to display the requested image 
            self.showLivePhotoView()
            self.livePhotoView.livePhoto = livePhoto
            
            // playback a shor section of the live photo
            if info![PHImageResultIsDegradedKey] != nil && !self.playingHint {
                self.playingHint = true
                self.livePhotoView.startPlaybackWithStyle(.Hint)
            }
            
            // update the toolbar 
            self.showPlaybackToobar()
        }
    }
    
    func updateStaticImage() {
        // options
        let options = PHImageRequestOptions()
        options.deliveryMode = .HighQualityFormat
        options.networkAccessAllowed = true
        options.progressHandler = {
            (progress: Double,
            error: NSError?,
            stop: UnsafeMutablePointer<ObjCBool>,
            info: [NSObject : AnyObject]?) in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.processView.progress = Float(progress)
            })
        }

        // get photo
        PHImageManager.defaultManager().requestImageForAsset(self.asset,
            targetSize: targetSize(),
            contentMode: PHImageContentMode.AspectFit,
            options: options) { (image, info) -> Void in
            
            guard image != nil else {
                return
            }
            
            // update bar and iamge
            self.showStaticPhotoView()
            self.imageView.image = image
        }
    }
}

// MARK: - Live Photo Delegate 
//
extension AssetViewController: PHLivePhotoViewDelegate {
    func livePhotoView(livePhotoView: PHLivePhotoView, willBeginPlaybackWithStyle playbackStyle: PHLivePhotoViewPlaybackStyle) {
        print("will begin playback")
    }
    
    func livePhotoView(livePhotoView: PHLivePhotoView, didEndPlaybackWithStyle playbackStyle: PHLivePhotoViewPlaybackStyle) {
        self.playingHint = false
        print("Did end playback")
    }
}


// MARK: - Library Change Delegate
//
extension AssetViewController: PHPhotoLibraryChangeObserver {
    
    func photoLibraryDidChange(changeInstance: PHChange) {
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            
            // Check if there are changes to the asset we're displaying.
            let changeDetails = changeInstance.changeDetailsForObject(self.asset)
            
            guard changeDetails != nil else {
                return
            }
            
            // get updated asset 
            self.asset = changeDetails?.objectAfterChanges as! PHAsset
            
            // If the asset's content changed, update the image and stop any video playback.
            if ((changeDetails?.assetContentChanged) != nil) {
                self.updateImage()
                self.playerLayer.removeFromSuperlayer()
                self.playerLayer = AVPlayerLayer()
            }
        }
    }
}


// MARK: - Targer Action Method 
// 
extension AssetViewController {
    func editTapped(sender: UIBarButtonItem) {
        print("Edit Button Tapped")
    }
    func transhTapped(sender: UIBarButtonItem) {
        print("Trash Button Tapped")
    }
    
    func playTapped(sender: UIBarButtonItem) {
        print("Playback Button Tapped")
        
        if livePhotoView.livePhoto != nil {
            self.livePhotoView.startPlaybackWithStyle(.Full)
            print("play lvie photo")
            
        } else if self.playerLayer.readyForDisplay {
            self.playerLayer.player?.play()
            print("play video")
            
        } else {
            PHImageManager.defaultManager().requestAVAssetForVideo(self.asset, options: nil, resultHandler: { (avAsset, avAudioMix, info) -> Void in
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    print("get layer")
                    if !self.playerLayer.readyForDisplay {
                        print("set video layer")
                    
                        let viewLayer = self.view.layer
                        
                        // Create an AVPlayerItem for the AVAsset.
                        let playerItem = AVPlayerItem(asset: avAsset!)
                        playerItem.audioMix = avAudioMix
                        
                        // Create an AVPlayer with the AVPlayerItem.
                        let player = AVPlayer(playerItem: playerItem)
                        
                        // Create an AVPlayerLayer with the AVPlayer.
                        let playerLayer = AVPlayerLayer(player: player)
                        
                        // Configure the AVPlayerLayer and add it to the view.
                        playerLayer.videoGravity = AVLayerVideoGravityResizeAspect
                        playerLayer.frame = self.view.frame//CGRectMake(0, 0, viewLayer.bounds.size.width, viewLayer.bounds.size.height)
                        
                        viewLayer.addSublayer(playerLayer)
                        
                        player.play()
                        
                        self.playerLayer = playerLayer
                    }
                })
            })
            
        }
    }
}