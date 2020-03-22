//
//  EDCHeaderView.swift
//  BlurNaviTableViewDemo
//
//  Created by FanYu on 26/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

protocol EDCHeaderViewDelegate: class {
    func lockHeaderView(_ maxOffset: CGFloat)
    func autoAdjustAlpha(_ alpha: CGFloat)
}

extension EDCHeaderViewDelegate where Self : UITableViewController {
    func lockHeaderView(_ maxOffset: CGFloat) {
        self.tableView.contentOffset.y = maxOffset
    }
    func autoAdjustAlpha(_ alpha: CGFloat) {
        self.navigationController?.navigationBar.setEDCNavigationBarAlpha(alpha)
    }
}


class EDCHeaderView: UIView {
    
    var contentView = UIView()
    var delegate: EDCHeaderViewDelegate!
    fileprivate var vc = UIViewController()
    fileprivate var imageView: UIImageView?
   
    init(image: String, headerSize: CGSize, delegate: EDCHeaderViewDelegate, vc: UIViewController) {
   
        // set header size
        super.init(frame: CGRect(x: 0, y: 0, width: headerSize.width, height: headerSize.height))
        
        // vc
        self.vc = vc
        
        // delegate
        self.delegate = delegate
        
        // subview view can outside the super view
        self.clipsToBounds = false
        
        // keep same size with superview
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: headerSize.width, height: headerSize.height))
        imageView!.image = UIImage(named: image)
        imageView!.contentMode = .scaleAspectFill
        imageView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // content view y = 0
        contentView.frame = self.bounds
        contentView.addSubview(imageView!)
        // image view inside the content view
        contentView.clipsToBounds = true
        
        // do not do this
        //self.clipsToBounds = true
        
        self.addSubview(contentView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func adjustHeaderView(_ offsetY: CGFloat, stickStatusBar: Bool) {
        
        if stickStatusBar {
            self.stickStatusBar(offsetY)
        } else {
            self.transAlphaNaviBar(offsetY)
        }
    }
    
    
    func transAlphaNaviBar(_ offset: CGFloat) {
        var rect = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        
        // 保持顶部不离开
        rect.origin.y += offset
        // 改变高度
        rect.size.height -= offset
        // contentview 相对于fatherview进行偏移
        self.contentView.frame = rect
        // delegate alpha
        //self.delegate.autoAdjustAlpha(1 + (offsetY - 36) / (64 + 36))
        self.vc.navigationController?.navigationBar.setEDCNavigationBarAlpha(1 + (offset - 36) / (64 + 36))

    }
    
    func stickStatusBar(_ offset: CGFloat) {
        var rect = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        
        // pull down
        if offset < -64 {
            rect.origin.y += (offset + 64)
            rect.size.height -= (offset + 64)
            self.contentView.frame = rect
            // make sure is -64
            self.vc.navigationController?.navigationBar.frame.origin.y = 20
        } else { // pull up
            
            self.vc.navigationController?.navigationBar.frame.origin.y = -offset - 44
            // make sure stick
            if offset >= -20 {
                self.vc.navigationController?.navigationBar.frame.origin.y = -24
            }
        }
    }
}
