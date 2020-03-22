//
//  BlurNaviBar.swift
//  ParallaxHeader
//
//  Created by FanYu on 29/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

struct CoverViewKey {
    static var key = "coverView"
}

extension UINavigationBar {
    // cover view which added to navi top
    private var coverView: UIView? {
        //这句的意思大概可以理解为利用key在self中取出对应的对象,如果没有key对应的对象就返回niu
        get {
            return objc_getAssociatedObject(self, &CoverViewKey.key) as? UIView
        }
        // 重新设置这个对象 OBJC_ASSOCIATION_RETAIN_NONATOMIC意味着:strong,nonatomic
        set {
            objc_setAssociatedObject(self, &CoverViewKey.key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // set color and alpha
    public func setEDCNavigationBar(color color: UIColor, alpha: CGFloat) {
        
        // make effectView transparent
        self.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        
        // hide the hairline
        self.shadowImage = UIImage()
        
        // cover view
        self.coverView = UIView(frame: CGRect(x: 0, y: -20, width: CGRectGetWidth(self.bounds), height: 64))
        self.coverView?.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        self.coverView?.userInteractionEnabled = false
        self.coverView?.backgroundColor = color
        self.coverView?.alpha = alpha
        
        // sub to navi bar
        self.insertSubview(coverView!, atIndex: 0)
    }
    
    // set alpha
    public func setEDCNavigationBarAlpha(alpha: CGFloat) {
        self.coverView?.alpha = alpha
    }
}
