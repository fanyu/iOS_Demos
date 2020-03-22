//
//  HeaderView.swift
//  
//
//  Created by FanYu on 9/14/15.
//
//

import UIKit

class HeaderView: UIView {
    
    private weak var associatedTableView: UITableView?
    
    private var backgroundView = UIView()
    private var backgroundImageView = UIImageView()
    
    private var foregroundView: UIView?
    private var foregroundOriginY: CGFloat?
    
    private var observerKeyPath = "contentOffset"
    private var observerContext = 0
    
    private var deltaScale = CGFloat(0.5)
    
    var topOffset = -CGFloat(200){
        didSet{
            foregroundView?.frame.origin.y -= topOffset
            foregroundOriginY = foregroundView?.frame.origin.y
        }
    }

    var maxZoomScale = CGFloat(1.5) {
        didSet {
            deltaScale = maxZoomScale - 1
        }
    }
    
    var maxPullDistance = CGFloat(170)
    
    init(tableView: UITableView, height: CGFloat, backgroundImage: UIImage?, foregroundView: UIView?) {
        super.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: height))
        
        associatedTableView = tableView
        backgroundImageView.image = backgroundImage
        foregroundOriginY = 0
        backgroundView.addSubview(backgroundImageView)
        
        if foregroundView != nil {
            self.foregroundView = foregroundView
            self.backgroundView.addSubview(foregroundView!)
        }
        
        layoutCustomerViews()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func layoutCustomerViews() {

        associatedTableView?.layoutIfNeeded()   // layout subviews immediatedly
        topOffset = -200
        associatedTableView?.tableHeaderView = self
        associatedTableView?.addObserver(self, forKeyPath: observerKeyPath, options: NSKeyValueObservingOptions.New, context: &observerContext)
        backgroundView.frame = CGRectMake(0, topOffset, self.frame.width, self.frame.height - topOffset)
        backgroundImageView.frame = backgroundView.bounds
        self.addSubview(backgroundView)
        backgroundView.clipsToBounds = true
    }

    func tableViewDidScroll() {
        var offSet_y = associatedTableView!.contentOffset.y
        
        if offSet_y >= 0 {
            backgroundImageView.frame.origin.y = offSet_y/3
            foregroundView?.frame.origin.y = foregroundOriginY! + offSet_y/4
        }else{
            var process = -CGFloat(offSet_y/maxPullDistance)
            if process > 1{
                process = 1
            }
            var zoomScale = CGFloat(1) + deltaScale * process
            backgroundImageView.transform = CGAffineTransformMakeScale(zoomScale, zoomScale)
        }

    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if keyPath == observerKeyPath {

        }
    }
}

