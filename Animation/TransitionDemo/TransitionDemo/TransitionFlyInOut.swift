//
//  TransitionFlyInOut.swift
//  TransitionDemo
//
//  Created by FanYu on 5/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class TransitionFlyInOut: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    // this is for MenuViewController
    var isPresenting = true
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView()
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let duration = transitionDuration(transitionContext)
        
        print(fromViewController)
        print(toViewController)
        
        let screens: (from: UIViewController, to: UIViewController) = (fromViewController!, toViewController!)
        
        // 还未显示时候，Meus作为from，显示后，Meus 作为to
        // 使得要显示的View位于最上部
        let menuViewController = !self.isPresenting ? screens.from as! MenuViewController : screens.to as! MenuViewController
        let bottomViewController = !self.isPresenting ? screens.to as! ViewController : screens.from as! ViewController
        
        let menuView = menuViewController.view
        let bottomView = bottomViewController.view
        
        container?.addSubview(bottomView)
        container?.addSubview(menuView)

        // prepare the mune to slide in
        if isPresenting {
            offStageMenuController(menuViewController)
        }
        
        UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: { () -> Void in
            
            if self.isPresenting {
                // menuVC is presenting, slide in items
                self.onStageMenuController(menuViewController)
            } else {
                // menuVC is dismissed, slide out items
                self.offStageMenuController(menuViewController)
            }
            
            }) { (Bool) -> Void in
                
                // finished
                transitionContext.completeTransition(true)
                
                // bug, we have to manually add toView back
                UIApplication.sharedApplication().keyWindow?.addSubview(screens.to.view)
        }
        
    }
    
    func offStage(amount: CGFloat) ->CGAffineTransform {
        return CGAffineTransformMakeTranslation(amount, 0)
    }
    
    // 准备开始动画的 透明度 和 位置
    func offStageMenuController(menuVC: MenuViewController) {
        
        menuVC.view.alpha = 0
        
        // parameters 
        let topRowOffset: CGFloat = 300
        let middleRowOffset: CGFloat = 150
        let bottomRowOffset: CGFloat = 50
        
        menuVC.view1.transform = self.offStage(-topRowOffset)
        menuVC.view2.transform = self.offStage(topRowOffset)
        
        menuVC.view3.transform = self.offStage(-middleRowOffset)
        menuVC.view4.transform = self.offStage(middleRowOffset)
        
        menuVC.view5.transform = self.offStage(-bottomRowOffset)
        menuVC.view6.transform = self.offStage(bottomRowOffset)
    }
    
    // 还原改变到最初的位置
    func onStageMenuController(menuVC: MenuViewController) {
        // prepare menu to fade in
        menuVC.view.alpha = 1
        
        menuVC.view1.transform = CGAffineTransformIdentity // 还原改变
        menuVC.view2.transform = CGAffineTransformIdentity
        menuVC.view3.transform = CGAffineTransformIdentity
        menuVC.view4.transform = CGAffineTransformIdentity
        menuVC.view5.transform = CGAffineTransformIdentity
        menuVC.view6.transform = CGAffineTransformIdentity
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        print(presented)
        print(presenting)
        print(source)
        print(self)
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        print(dismissed)
        return self
    }

}
