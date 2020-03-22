//
//  ViewController.swift
//  CATransitionAnimation
//
//  Created by FanYu on 16/1/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setup() {
        // image view
        imageView.frame = self.view.frame
        imageView.image = UIImage(named: "1")
        self.view.addSubview(imageView)
        
        // gesture
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: "leftSwipe:")
        leftSwipe.direction = .Left
        self.view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: "rightSwipe:")
        rightSwipe.direction = .Right
        self.view.addGestureRecognizer(rightSwipe)
    }

    func leftSwipe(gesture: UISwipeGestureRecognizer) {
        transitionAnimaton(true)
    }
    
    func rightSwipe(gesture: UISwipeGestureRecognizer) {
        transitionAnimaton(false)
    }
    
    func transitionAnimaton(isNext: Bool) {
        let transitionAnim = CATransition()
        transitionAnim.duration = 1
        
        // type
        transitionAnim.type = TransitionType.rippleEffect
        if isNext {
            transitionAnim.subtype = kCATransitionFromRight
        } else {
            transitionAnim.subtype = kCATransitionFromLeft
        }
        
        imageView.image = getImage(isNext)
        imageView.layer.addAnimation(transitionAnim, forKey: "transition")
    }
    
    func getImage(isNext: Bool) -> UIImage {
        if isNext {
            return UIImage(named: "2")!
        } else {
            return UIImage(named: "1")!
        }
        
//        if (isNext) {
//            currentIndex=(_currentIndex+1)%IMAGE_COUNT;
//        }else{
//            _currentIndex=(_currentIndex-1+IMAGE_COUNT)%IMAGE_COUNT;
//        }
    }
}


struct TransitionType {
    static let cube = "cube"
    static let oglFlip = "oglFlip"
    static let suckEffect = "suckEffect"
    static let rippleEffect = "rippleEffect"
    static let pageCurl = "pageCurl"
    static let cameralIrisHollowOpen = "cameralIrisHollowOpen"
    static let cameralIrisHollowClose = "cameralIrisHollowClose"
}

