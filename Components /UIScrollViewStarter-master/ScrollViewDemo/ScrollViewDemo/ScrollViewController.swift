//
//  ViewController.swift
//  ScrollViewController
//
//  Created by Joyce Echessa on 6/3/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {

    var scrollView: UIScrollView?
    var imageView: UIImageView?
    
    var one = UIImageView()
    var two: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Before one: \(one.frame) \t two: \(two?.frame)")
        
        one.image = UIImage(named: "11")
        two = UIImageView(image: UIImage(named: "11"))
        
        print("After  one: \(one.frame) \t two: \(two?.frame)")
        
        
        
        
        //println(view.bounds.size)
        imageView = UIImageView(image: UIImage(named: "11"))
        
        scrollView = UIScrollView(frame: view.bounds)
        
        // delegate must after initating
        scrollView?.delegate = self
        scrollView?.backgroundColor = UIColor.whiteColor()
        scrollView?.contentSize = imageView!.bounds.size
        scrollView?.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        //scrollView?.contentOffset = CGPoint(x: 1000, y: 450)
        scrollView!.addSubview(imageView!)
        view.addSubview(scrollView!)
        
        setZoomScale()
        setGestureRecognizer()
    }
    
    func setZoomScale() {
        let imageViewSize = imageView!.bounds.size
        let scrollViewSize = scrollView!.bounds.size
        
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        
        scrollView?.minimumZoomScale = min(widthScale, heightScale)
        scrollView?.zoomScale = (scrollView?.minimumZoomScale)!
    }
    
    override func viewWillLayoutSubviews() {
        setZoomScale()
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        
        // make it in the center
        let imageViewSize = imageView!.frame.size
        let scrollViewSize = scrollView.bounds.size
        
        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0
        
        scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
    }
    
    func setGestureRecognizer() {
        let doubleTap = UITapGestureRecognizer(target: self, action: "handleDoubleTap:")
        doubleTap.numberOfTapsRequired = 2
        scrollView?.addGestureRecognizer(doubleTap)
    }
    
    func handleDoubleTap(recognier: UITapGestureRecognizer) {
        if scrollView!.zoomScale > scrollView!.minimumZoomScale {
            scrollView!.setZoomScale(scrollView!.minimumZoomScale, animated: true)
            // println(">")
        } else {
            scrollView!.setZoomScale(scrollView!.maximumZoomScale, animated: true)
            // println("<")
        }
    }
}

extension ScrollViewController: UIScrollViewDelegate {
    
    // scale image
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}
