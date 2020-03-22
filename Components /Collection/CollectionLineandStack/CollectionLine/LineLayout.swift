//
//  LineLayout.swift
//  CollectionLine
//
//  Created by FanYu on 20/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class LineLayout: UICollectionViewFlowLayout {
    
    // paras
    let itemWidth: CGFloat = 100
    let itemHeight: CGFloat = 100
    
    // inset 
    // 这样设置，inset就只会被计算一次，减少了prepareLayout的计算步骤
    lazy var inset: CGFloat = {
        return  (self.collectionView?.bounds.width ?? 0)  * 0.5 - self.itemSize.width * 0.5
    }()
    
    override init() {
        super.init()
        
        self.itemSize = CGSize(width: itemWidth, height: itemHeight)
        self.scrollDirection = .Horizontal
        self.minimumLineSpacing = 0.7 * itemWidth
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // prepare
    //苹果推荐，对一些布局的准备操作放在这里
    override func prepareLayout() {
        self.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }
    
    // recalulate when changed
    /**
    返回true只要显示的边界发生改变就重新布局:(默认是false)
    内部会重新调用prepareLayout和调用
    layoutAttributesForElementsInRect方法获得部分cell的布局属性
    */
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    // 设置Layout地方
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        //取出rect范围内所有的UICollectionViewLayoutAttributes，然而
        //我们并不关心这个范围内所有的cell的布局，我们做动画是做给人看的，
        //所以我们只需要取出屏幕上可见的那些cell的rect即可
        
        let attributes = super.layoutAttributesForElementsInRect(rect)
        
        
        
        let maxCenterMargin = (self.collectionView?.bounds.width)! * 0.5 + itemWidth * 0.5
        let centerX = (self.collectionView?.contentOffset.x)! + self.collectionView!.frame.size.width * 0.5
        
        let visiableRect = CGRect(x: self.collectionView!.contentOffset.x, y: collectionView!.contentOffset.y, width: self.collectionView!.frame.size.width, height: self.collectionView!.frame.size.height)
        
        for attribute in attributes! {
            
            // 没有相交，则不设置参数
            if !CGRectIntersectsRect(visiableRect, attribute.frame) { continue }
            
            let scale = 1 + (0.8 - abs(centerX - attribute.center.x) / maxCenterMargin)
            attribute.transform = CGAffineTransformMakeScale(scale, scale)
        }
        
        return attributes
    }
    
    /**
     用来设置collectionView停止滚动那一刻的位置
     
     - parameter proposedContentOffset: 原本collectionView停止滚动那一刻的位置
     - parameter velocity:              滚动速度
     
     - returns: 最终停留的位置
     */
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        let lastRect = CGRectMake(proposedContentOffset.x, proposedContentOffset.y, self.collectionView!.frame.width, self.collectionView!.frame.height)
        
        //获得collectionVIew中央的X值(即显示在屏幕中央的X)
        let centerX = proposedContentOffset.x + self.collectionView!.frame.width * 0.5;
        //这个范围内所有的属性
        let array = self.layoutAttributesForElementsInRect(lastRect)
        
        //需要移动的距离
        var adjustOffsetX = CGFloat(MAXFLOAT);
        for attri in array! {
            if abs(attri.center.x - centerX) < abs(adjustOffsetX) {
                adjustOffsetX = attri.center.x - centerX;
            }
        }
        
        return CGPointMake(proposedContentOffset.x + adjustOffsetX, proposedContentOffset.y)
    }
}