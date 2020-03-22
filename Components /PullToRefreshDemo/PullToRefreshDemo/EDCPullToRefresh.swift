//
//  EDCPullToRefresh.swift
//  PullToRefresh
//
//  Created by FanYu on 31/10/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class EDCPullToRefresh: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var refreshView: RefreshView!
    @IBOutlet var loadMoreView: LoadMoreView!
    
    var isRefreshing: Bool!
    var isLoading: Bool!
    var cellNum: Int!
    
    let circleView = CircleView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isRefreshing = true
        isLoading = true
        
        setupRefreshView()
        
        isRefreshing = false
        isLoading = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


// MARK: - Setup
// 
extension EDCPullToRefresh {

    func setupRefreshView() {
        // collection
        cellNum = 20
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.backgroundColor = UIColor(red:0.37, green:0.37, blue:0.37, alpha:1)
        
        // refresh view
        refreshView.frame = CGRect(x: 10, y: -70, width: self.view.bounds.size.width, height: 70)
        refreshView.backgroundColor = UIColor(red:0.37, green:0.37, blue:0.37, alpha:1)
        self.collectionView.addSubview(refreshView)
        
        // load more view
        loadMoreView.frame = CGRect(x: 0, y: -600, width: self.view.bounds.size.width, height: 70)
        loadMoreView.backgroundColor = UIColor(red:0.37, green:0.37, blue:0.37, alpha:1)
        self.collectionView.addSubview(loadMoreView)
        
        // cirle view
        circleView.frame = CGRect(x: 10, y: 15, width: 40, height: 40)
        circleView.backgroundColor = UIColor(red:0.37, green:0.37, blue:0.37, alpha:1)
        refreshView.addSubview(circleView)
    }
}


// MARK: - Scroll Delegate
//
extension EDCPullToRefresh {
    
    // 用来控制下拉 动画offset时候使用
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        // 偏移量
        let offset = scrollView.contentOffset.y + scrollView.contentInset.top
        
        // 下拉 控制动画偏移量
        if offset <= 0.0 && !self.isRefreshing {
            
            let startLoadingThreshold: CGFloat = 90
            let fractionDragged = -offset / startLoadingThreshold
            
            self.circleView.layer.timeOffset = min(1, Double(fractionDragged))
        }
        
        // 下拉状态字改变
        if scrollView.contentOffset.y < -70 && !isRefreshing{
            self.refreshView.labelForRefresh.text = "Release to Refresh"
        } else if scrollView.contentOffset.y >= -70 && !isRefreshing {
            self.refreshView.labelForRefresh.text = "Pull Down to Refresh"
        }
        
        // 上拉状态字改变
        if scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height + 70 && !isLoading {
            self.loadMoreView.labelForLoadMore.text = "Release to Load More"
        } else if !isLoading && scrollView.contentOffset.y + scrollView.frame.size.height <= scrollView.contentSize.height + 70 {
            self.loadMoreView.labelForLoadMore.text = "Pull Up to Load"
        }
    }
    
    // Change loadMoreView position
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        loadMoreView.frame.origin.y = scrollView.contentSize.height
    }
    
    // 将要开始减速时，即为手刚刚结束滑动时，此时执行动画会很平缓，如果在endDragging时，则会有突变效果 不流畅
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        if self.collectionView.contentOffset.y < -70 {
            self.startRefreshing()
        }
        
        if scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height + 70 {
            self.startLoading()
        }
    }
}




// MARK: - Animation 
//
extension EDCPullToRefresh {
    
    func startRefreshing() {
        
        self.isRefreshing = true
        
        self.refreshView.labelForRefresh.text = "loading"
        self.refreshView.activityIndicator.startAnimating()
        
        // 使得由当前位置 动画到 content＋refreshView.frame
        UIView.animateWithDuration(0.7, animations: { () -> Void in
            self.collectionView.contentInset = UIEdgeInsets(top: 70, left: 0, bottom: 0, right: 0)

            }) { (Bool) -> Void in
        }
        
        // 加载数据
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(2) * Int64(NSEC_PER_SEC))
        
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                // 恢复 inset.top 为 原来数值
                self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                
                }, completion: { (Bool) -> Void in
                    self.refreshView.labelForRefresh.text = "Pull Down to Refresh"
                    self.refreshView.activityIndicator.stopAnimating()
                    self.collectionView.scrollEnabled = true
                    self.isRefreshing = false
            })
        }
    }
    
    func startLoading() {
        
        self.isLoading = true
        
        self.loadMoreView.labelForLoadMore.text = "Loading"
        self.loadMoreView.activityIndicator.startAnimating()
        
        UIView.animateWithDuration(0.7, animations: { () -> Void in
            self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 70, right: 0)

            }) { (Bool) -> Void in
        }
        
        // 加载数据
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(2) * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            
            self.cellNum = 10 + self.cellNum
            
            // 加载完后
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                // 恢复 inset.bottom 为 原来数值
                self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                
                }, completion: { (Bool) -> Void in
                    self.loadMoreView.labelForLoadMore.text = "Pull Up to Load More"
                    self.loadMoreView.activityIndicator.stopAnimating()
                    self.isLoading = false
                    // 加载完后 刷新数据
                    self.collectionView.reloadData()
            })
        }
    }
}



// MARK: - CollectionView DataSource
//
extension EDCPullToRefresh: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellNum
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
        
        return cell
    }
    
}


// MARK: - CollectionView Delegate FlowLayout
//
extension EDCPullToRefresh: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let itemWidth = (view.bounds.size.width - 2) / 3
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 1, bottom: 1, right: 1)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
}