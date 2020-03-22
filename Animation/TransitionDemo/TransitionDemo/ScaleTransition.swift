//
//  ScaleTransition.swift
//  TransitionDemo
//
//  Created by FanYu on 7/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class ScaleTransition: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    private var presenting = true
    
    // animate a change from one viewcontroller to another
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView()
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let duration = transitionDuration(transitionContext)
        
        let screens: (from: UIViewController, to: UIViewController) = (fromViewController!, toViewController!)
        
        let menuViewController = !self.presenting ? screens.from as! MenuViewController : screens.to as! MenuViewController
        let topViewController = !self.presenting ? screens.to as UIViewController : screens.from as UIViewController
        
        let menuView = menuViewController.view
        let topView = topViewController.view
        
        // add both view to view controller
        container?.addSubview(menuView)
        container?.addSubview(topView)
        
        if presenting {
            menuView.transform = CGAffineTransformMakeScale(1, 1)
            menuView.alpha = 1
        } else {
            topView.transform = CGAffineTransformMakeScale(1, 1)
            topView.alpha = 1
        }
        
        // animation
        UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: { () -> Void in
            
            if self.presenting {
                topView.transform = CGAffineTransformMakeScale(0.1, 0.1)
                topView.alpha = 0
                //menuView.alpha = 1
                //menuView.transform = CGAffineTransformIdentity
            } else {
                menuView.transform = CGAffineTransformMakeScale(0.1, 0.1)
                menuView.alpha = 0
                
                //topView.alpha = 1
                //topView.transform = CGAffineTransformIdentity
            }
            
            }) { (Bool) -> Void in
                transitionContext.completeTransition(true)
                //UIApplication.sharedApplication().keyWindow?.addSubview(screens.to.view)
//                if self.presenting {
//                    //transitionContext.completeTransition(false)
//                    //menuView.transform = CGAffineTransformMakeScale(1, 1)
//                    UIApplication.sharedApplication().keyWindow?.addSubview(topView)
//                    //topView.transform = CGAffineTransformIdentity
//                    
//                } else {
//                    //transitionContext.completeTransition(true)
//                    //topView.transform = CGAffineTransformMakeScale(1, 1)
//                    UIApplication.sharedApplication().keyWindow?.addSubview(menuView)
//                    //topView.alpha = 1
//                }
                //transitionContext.completeTransition(true)

                UIApplication.sharedApplication().keyWindow?.addSubview(screens.from.view)
                UIApplication.sharedApplication().keyWindow?.addSubview(screens.to.view)

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
