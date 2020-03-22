//
//  RotateTransition.swift
//  TransitionDemo
//
//  Created by FanYu on 7/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class RotateTransition: NSObject ,UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    private var presenting = true
    
    // animate a change from one viewcontroller to another
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        // get reference
        let container = transitionContext.containerView()
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
        
        let offScreenRotateIn = CGAffineTransformMakeRotation(-(3.14 / 2))
        let offScreenRotateOut = CGAffineTransformMakeRotation(3.14 / 2)
        
        toView?.transform = self.presenting ? offScreenRotateIn : offScreenRotateOut
        
        // set the anchor point so that rotations happen from the top-left corner
        toView?.layer.anchorPoint = CGPoint(x: 0, y: 0)
        fromView?.layer.anchorPoint = CGPoint(x: 0, y: 0)
        
        // updating the anchor point also moves the position to we have to move the center position to the top-left to compensate
        toView?.layer.position = CGPoint(x: 0, y: 0)
        fromView?.layer.position = CGPoint(x: 0, y: 0)
        
        // add the both views to our view controller
        container?.addSubview(toView!)
        container?.addSubview(fromView!)
        
        
        // duration
        let duration = self.transitionDuration(transitionContext)
        
        // perform animation ｜ to 与 from 左右一定是相反的
        UIView.animateWithDuration(duration, animations: { () -> Void in
            
            fromView?.transform = self.presenting ? offScreenRotateOut : offScreenRotateIn
            
            toView?.transform = CGAffineTransformIdentity
            }) { (Bool) -> Void in
                transitionContext.completeTransition(true)
        }
    }
    
    // duration
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    // return an animator when presenting a VC
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    // return an animator when dismissing a VC
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }

}
