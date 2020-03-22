//
//  InteractiveTransition.swift
//  TransitionDemo
//
//  Created by FanYu on 6/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

// 有两种形式，
// 第一，移动整个View，进行左右移动. 此方法只要获取View就OK了
// 第二，移动View里面的内容，这样就需要获取ViewController，才可以通过这个获取到里面的内容

import UIKit

class InteractiveTransition: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    // private: only be referenced within this object
    private var presenting = false
    private var interactive = false
    
    private var enterPanGesture: UIScreenEdgePanGestureRecognizer!
    private var statusBarBackground: UIView!
    
    // not private, so can also be used from other objects
    var sourceViewController: UIViewController! {
        didSet {
            self.enterPanGesture = UIScreenEdgePanGestureRecognizer()
            self.enterPanGesture.addTarget(self, action: "handleOnstagePan:")
            self.enterPanGesture.edges = UIRectEdge.Left
            self.sourceViewController.view.addGestureRecognizer(self.enterPanGesture)
            
            // view to go behind statusbar
            self.statusBarBackground = UIView()
            self.statusBarBackground.frame = CGRect(x: 0, y: 0, width: self.sourceViewController.view.frame.width, height: 20)
            self.statusBarBackground.backgroundColor = UIColor.orangeColor()//self.sourceViewController.view.backgroundColor
            
            // add to window rather than view controller
            UIApplication.sharedApplication().keyWindow?.addSubview(self.statusBarBackground)
        }
    }
    
    private var exitPanGesture: UIPanGestureRecognizer!
    
    var menuViewController: UIViewController! {
        didSet {
            self.exitPanGesture = UIPanGestureRecognizer()
            self.exitPanGesture.addTarget(self, action: "handleOffstagePan:")
            self.menuViewController.view.addGestureRecognizer(self.exitPanGesture)
        }
    }
    
    func handleOnstagePan(pan: UIPanGestureRecognizer) {
        
        // how much distance have we panned in reference to the parent view?
        let translation = pan.translationInView(pan.view!)
        let d = translation.x / CGRectGetWidth((pan.view?.bounds)!) * 0.5
        
        switch pan.state {
        case UIGestureRecognizerState.Began:
            self.interactive = true
            
            // trigger the start of the transition
            self.sourceViewController.performSegueWithIdentifier("Show", sender: self)
            
        case UIGestureRecognizerState.Changed:
            self.updateInteractiveTransition(d)
            
        default: // cancled, ended, failed
            self.interactive = false
            if d > 0.2 {
                self.finishInteractiveTransition()
            } else {
                self.cancelInteractiveTransition()
            }
        }
    }
    
    func handleOffstagePan(pan: UIPanGestureRecognizer) {
        let translation = pan.translationInView(pan.view)
        let d = translation.x / CGRectGetWidth((pan.view?.bounds)!) * -0.5
        
        switch pan.state {
        case UIGestureRecognizerState.Began :
            self.interactive = true
            self.menuViewController.performSegueWithIdentifier("Hide", sender: self)

        case UIGestureRecognizerState.Changed :
            self.updateInteractiveTransition(d)
            
        default :
            self.interactive = false
            if d > 0.1 {
                self.finishInteractiveTransition()
            } else {
                self.cancelInteractiveTransition()
            }
        }
        
    }
    
    // MARK: UIViewControllerAnimatedTransitioning protocol methods
    //
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        // get reference
        let container = transitionContext.containerView()
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let duration = transitionDuration(transitionContext)
        
        let screens: (from: UIViewController, to: UIViewController) = (fromViewController!, toViewController!)
        
        // 第一次将要显示时，mVC ＝ toVC，下一次显示后，mVC就是fromVC
        // from and to 是交替变换的，要始终确保相对应的为MenuViewController
        let menuViewController = !self.presenting ? screens.from as! MenuViewController : screens.to as! MenuViewController
        let topViewController = !self.presenting ? screens.to as UIViewController : screens.from as UIViewController
        
        let menuView = menuViewController.view
        let topView = topViewController.view
        
        // prepare the mune to slide in 将要显示，先做准备
        if presenting {
            //offStageMenuControllerInteractive(menuViewController)
            menuView.transform = self.offStage(-container!.frame.width)
        }
        
        // add both view to view controller
        container?.addSubview(menuView)
        container?.addSubview(topView)
        container?.addSubview(self.statusBarBackground)
        
        // animation
        UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: { () -> Void in
            
            if self.presenting {
                // menuVC is presenting, slide in items
                //self.onStageMenuController(menuViewController)
                menuView.transform = CGAffineTransformIdentity
                //topView.transform = self.offStage(310)
                let scale = CGAffineTransformMakeScale(0.6, 0.6)
                let move = CGAffineTransformMakeTranslation(310, 0)
                topView.transform = CGAffineTransformConcat(move, scale)
                topView.layer.zPosition = 1
                
            } else {
                // menuVC is dismissed, slide out items
                topView.transform = CGAffineTransformIdentity
                //self.offStageMenuControllerInteractive(menuViewController)
                menuView.transform = self.offStage(-(container?.frame.width)!)
            }
            
            }) { (Bool) -> Void in
                
                if transitionContext.transitionWasCancelled() {
                    transitionContext.completeTransition(false)
                    UIApplication.sharedApplication().keyWindow?.addSubview(screens.from.view)
                    
                } else {
                    transitionContext.completeTransition(true)
                    UIApplication.sharedApplication().keyWindow?.addSubview(screens.from.view)
                    UIApplication.sharedApplication().keyWindow?.addSubview(screens.to.view)

                }
                UIApplication.sharedApplication().keyWindow?.addSubview(self.statusBarBackground)
        }
    }
    
    
    func offStage(amount: CGFloat) ->CGAffineTransform {
        return CGAffineTransformMakeTranslation(amount, 0)
    }
    
    // 准备开始动画的 透明度 和 位置
    func offStageMenuControllerInteractive(menuVC: MenuViewController) {
        
        menuVC.view.alpha = 0
        self.statusBarBackground.backgroundColor = self.sourceViewController.view.backgroundColor
        
        // parameters
        let offstageOffset: CGFloat = -200
        
        menuVC.view1.transform = self.offStage(offstageOffset)
        menuVC.view2.transform = self.offStage(offstageOffset)
        
        menuVC.view3.transform = self.offStage(offstageOffset)
        menuVC.view4.transform = self.offStage(offstageOffset)
        
        menuVC.view5.transform = self.offStage(offstageOffset)
        menuVC.view6.transform = self.offStage(offstageOffset)
    }
    
    // 还原改变到最初的位置
    func onStageMenuController(menuVC: MenuViewController) {
        // prepare menu to fade in
        menuVC.view.alpha = 1
        self.statusBarBackground.backgroundColor = UIColor.blackColor()
        
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
    
    
    // MARK: UIViewControllerTransitioningDelegate protocol methods
    // 判断是否在 presenting or dismissed 是否在进行 interactive or regular
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
    
    // return the transition manager object if our interactive flag is true or return nil if we’re just performing a regular animated transition.
    func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactive ? self : nil
    }
    
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactive ? self : nil
    }
}

