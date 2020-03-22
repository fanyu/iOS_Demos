//
//  TransitionManager.swift
//  TransitionDemo
//
//  Created by FanYu on 5/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    private var presenting = true

    // animate a change from one viewcontroller to another
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        // get reference 
        let container = transitionContext.containerView()
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
    
        // set up from 2D transforms that we will use in the animation
        let offScreenRight = CGAffineTransformMakeTranslation(container!.frame.width, 0)
        let offScreenLeft = CGAffineTransformMakeTranslation(-container!.frame.width, 0)
        
        // start the toView to the right of the screen
        toView?.transform = offScreenRight
        
        // forward and back
        if self.presenting {
            toView?.transform = offScreenRight
        } else {
            toView?.transform = offScreenLeft
        }

        
        // add the both views to our view controller
        container?.addSubview(toView!)
        container?.addSubview(fromView!)
        
        // duration
        let duration = self.transitionDuration(transitionContext)
        
        // perform animation ｜ to 与 from 左右一定是相反的
        UIView.animateWithDuration(duration, animations: { () -> Void in
            //fromView?.transform = offScreenLeft
            
            // another way
            if self.presenting {
                fromView?.transform = offScreenLeft
            } else {
                fromView?.transform = offScreenRight
            }
            
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
