//
//  MyLayout.swift
//  
//
//  Created by FanYu on 9/10/15.
//
//

import UIKit

struct UltraVisualConstant {
    static let standardHeight: CGFloat = 100
    static let featuredHeight: CGFloat = 280
}

class MyLayout: UICollectionViewLayout {
    
    var width: CGFloat {
        get {
            return CGRectGetWidth(collectionView!.bounds)
        }
    }
    var height: CGFloat {
        get {
            return CGRectGetHeight(collectionView!.bounds)
        }
    }
    var numberOfItems: Int {
        get {
            return collectionView!.numberOfItemsInSection(0)
        }
    }
    
    var cache = [UICollectionViewLayoutAttributes]()
    
    // The amount the user needs to scroll before the featured cell changes
    let dragOffset: CGFloat = 180
    // Returns the item index of the currently featured cell
    var featuredItemIndex: Int {
        get {
            return max(0, Int(collectionView!.contentOffset.y / dragOffset))
        }
    }
    // Returns a value between 0 and 1 that represents how close the next cell is to becoming the featured cell
    var nextItemPercentageOffset: CGFloat {
        get {
            return (collectionView!.contentOffset.y / dragOffset) - CGFloat(featuredItemIndex)
        }
    }
    
    override func collectionViewContentSize() -> CGSize {
        let contentHeight = (CGFloat(numberOfItems) * dragOffset) + (height - dragOffset)
        return CGSize(width: width, height: contentHeight)
    }
    
    override func prepareLayout() {
        // remove all elements
        cache.removeAll(keepCapacity: false)
        
        let standardHeight = UltraVisualConstant.standardHeight
        let featuredHeight = UltraVisualConstant.featuredHeight
        
        var frame = CGRectZero
        var frameY: CGFloat = 0
        
        
        // 计算每个item的frame，从静态开始，一个一个想
        for item in 0 ..< numberOfItems {
            let indexPath = NSIndexPath(forItem: item, inSection: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
            // 置于不同的层，有种覆盖的感觉
            attributes.zIndex = item
            
            var height = standardHeight
            
            if indexPath.item == featuredItemIndex {
                let yOffset = standardHeight * nextItemPercentageOffset
                // frame Y的坐标 ＝ 移动的距离(180最大)，最终要一共减少standardHeight距离，才能保证在移动180后，使得下一个完全移动到定端，否则在还没达到最顶部时，即差一个standardHeight高度，下一个已经变成featuredItem了
                frameY = collectionView!.contentOffset.y - yOffset
                // 高度不改变，只是改变Y距离，会移除屏幕，并且最后一小段会被下一个item覆盖
                height = width//featuredHeight
            } else if indexPath.item == (featuredItemIndex + 1) && indexPath.item != numberOfItems {
                // frame Y起点高度
                let maxY = frameY + standardHeight
                // item的高度 逐渐增长
//                height = standardHeight + max(0, (featuredHeight - standardHeight) * nextItemPercentageOffset )
                height = standardHeight + max(0, (width - standardHeight) * nextItemPercentageOffset )
                // 改变后的frame Y高度
                frameY = maxY - height
            }
            
            frame = CGRect(x: 0, y: frameY, width: width, height: height)
            
            frameY = CGRectGetMaxY(frame)
            
            attributes.frame = frame
            cache.append(attributes)
        }
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            // 两个rect有相交，即在rect范围内的attributes才进行设置
            if CGRectIntersectsRect(attributes.frame, rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    // Cell Snapping
    // 类似于 UIPageViewController 切换时的场景，只有当 scrollView 的滚动距离超过 cell height 一半，就会自动滚动一个 cell height，没有超过则复位
    // CGPoint，表示你想让内容滚动多少距离（content offset），原始默认的原始滚动距离通过参数 proposedContentOffset 提供
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        let index = round(proposedContentOffset.y / dragOffset)
        let yOffset = index * dragOffset
        return CGPoint(x: 0, y: yOffset)
    }
    
}
