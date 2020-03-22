//
//  NaviExtension.swift
//  BlurNaviTableViewDemo
//
//  Created by FanYu on 25/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//
import UIKit

struct CoverViewKey {
    static var key = "coverView"
}

extension UINavigationBar {
    
    // cover view which added to navi top
    fileprivate var coverView: UIView? {
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
    public func setEDCNavigationBar(color: UIColor, alpha: CGFloat) {
        
        // make effectView transparent
        self.setBackgroundImage(UIImage(), for: .default)
        
        // hide the hairline
        self.shadowImage = UIImage()
        
        // cover view
        self.coverView = UIView(frame: CGRect(x: 0, y: -20, width: self.bounds.width, height: 64))
        self.coverView?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.coverView?.isUserInteractionEnabled = false
        self.coverView?.backgroundColor = color
        self.coverView?.alpha = alpha
        
        // sub to navi bar
        self.insertSubview(coverView!, at: 0)
    }
    
    // set alpha
    public func setEDCNavigationBarAlpha(_ alpha: CGFloat) {
        self.coverView?.alpha = alpha
    }
}

// 简单版本
//private func setupNaviBar() {
//    // navi abr transparent
//    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
//    self.navigationController?.navigationBar.shadowImage = UIImage()
//    
//    // slef define cover view
//    let coverView = UIView(frame: CGRect(x: 0, y: -20, width: CGRectGetWidth((self.navigationController?.navigationBar.bounds)!), height: 64))
//    coverView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
//    coverView.backgroundColor = UIColor.whiteColor()
//    coverView.alpha = 0
//    
//    // sub
//    //objc_setAssociatedObject(coverView, nil, coverView.self, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//    self.navigationController?.navigationBar.insertSubview(coverView, atIndex: 0)
//}
