//
//  PhotoViewerVC.swift
//  PhotoBrowser
//
//  Created by FanYu on 21/10/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class PhotoViewerVC: UIViewController {

    var photo      = UIImage()  // from previous 
    let album      = ["3", "3", "3","3", "3"]
    
    var imageView: UIImageView?
    let scrollView = UIScrollView()
    let spinner    = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
    var defaultZoomScale: CGFloat?
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //imageView?.image = UIImage(named: "2")
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillLayoutSubviews() {
        let imageViewSize = imageView!.bounds.size
        let scrollViewSize = scrollView.bounds.size
        
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.width
        
        scrollView.maximumZoomScale = max(widthScale, heightScale) + 1
        scrollView.minimumZoomScale = min(widthScale, heightScale)
        defaultZoomScale = max(widthScale, heightScale) + 0.07
        
        scrollView.zoomScale = scrollView.minimumZoomScale
    }
}


// MARK: - SetUp View
extension PhotoViewerVC {
    
    func setupView() {
        // Scroll View
        scrollView.delegate         = self
        scrollView.frame            = view.bounds
        scrollView.contentSize = CGSize(width: view.bounds.size.width * CGFloat(album.count), height: view.bounds.size.height)
        scrollView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        scrollView.backgroundColor = UIColor.blackColor()
        view.addSubview(scrollView)
        
        
        // Image View
        imageView = UIImageView(image: photo)
        scrollView.addSubview(imageView!)
        
//        for i in 0 ..< album.count {
//            //imageView?.frame.origin.x = self.view.frame.size.width * CGFloat(i)
//            //print(imageView?.frame)
//            imageView?.frame = CGRect(x: self.view.bounds.width * CGFloat(i), y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
//            imageView = UIImageView(image: UIImage(named: album[i]))
//            
//            imageView?.frame.origin.x = self.view.frame.size.width * CGFloat(i)
//            scrollView.addSubview(imageView!)
//        }
        
        
        // Tap Gesture
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: "handleDoubleTap:")
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.numberOfTouchesRequired = 1 // fingures
        scrollView.addGestureRecognizer(doubleTapRecognizer)
        
        let singleTapRecognizer = UITapGestureRecognizer(target: self, action: "handleSingleTap:")
        singleTapRecognizer.numberOfTapsRequired = 1
        singleTapRecognizer.numberOfTouchesRequired = 1
        scrollView.addGestureRecognizer(singleTapRecognizer)
        
        // singe tap and double tap can work together
        singleTapRecognizer.requireGestureRecognizerToFail(doubleTapRecognizer)
    }
    
}


// MARK: - Scrollview Delegate
extension PhotoViewerVC: UIScrollViewDelegate {
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        centerScrollViewContents()
        
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}


// MARK: - Tap Gesture
extension PhotoViewerVC {
    
    // Double
    func handleDoubleTap(sender: UIGestureRecognizer) {
        let pointInView = sender.locationInView(self.imageView)
        self.zoomInZoomOut(pointInView)
    }
    
    // Single
    func handleSingleTap(sender: UITapGestureRecognizer) {
        dismissViewControllerAnimated(false, completion: nil)
    }
}


// MARK: - Helper Zoom
extension PhotoViewerVC {
    
    func centerScrollViewContents() {
        let boundsSize = scrollView.frame
        var contentsFrame = self.imageView!.frame
        
        if contentsFrame.size.width < boundsSize.width {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2
        } else {
            contentsFrame.origin.x = 0
        }
        
        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2
        } else {
            contentsFrame.origin.y = 0
        }
        
        self.imageView!.frame = contentsFrame
    }
    
    func zoomInZoomOut(point: CGPoint!) {
        // zoom in or zoom out according acurrent zoom scale
        let newZoomScale   = self.scrollView.zoomScale > self.scrollView.minimumZoomScale ? self.scrollView.minimumZoomScale : defaultZoomScale//self.scrollView.maximumZoomScale

        let scrollViewSize = self.scrollView.bounds.size
        
        // 新的高宽
        let width          = scrollViewSize.width / newZoomScale!
        let height         = scrollViewSize.height / newZoomScale!
        // 以点击的Point为中点，减去新高宽的一半，则为新Frame的x，y 坐标
        let x              = point.x - width / 2
        let y              = point.y - height / 2
        
        let rectToZoom     = CGRect(x: x, y: y, width: width, height: height)

        // scrollview 会放大到这个新的Frame，以它为展示
        self.scrollView.zoomToRect(rectToZoom, animated: true)
    }
}

