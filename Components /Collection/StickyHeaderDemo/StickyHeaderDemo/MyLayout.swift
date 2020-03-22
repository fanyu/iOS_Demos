//
//  MyLayout.swift
//  
//
//  Created by FanYu on 9/8/15.
//
//

import UIKit

class MyLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // get all attributes that showed on the screen from super
        var layoutAttributes = super.layoutAttributesForElementsInRect(rect) as? [UICollectionViewLayoutAttributes]
        
        // a mutable collection of unique unsigned integers
        let headersNeedingLayout = NSMutableIndexSet()
        
        // 找出当前 cell 对应的 section 索引
        for attribute in layoutAttributes {
            if attribute.representedElementCategory == .Cell {
                headersNeedingLayout.addIndex(attribute.indexPath.section)
            }
        }
        
        // 遍历当前屏幕上显示的所有header 然后将还显示在屏幕上的header对应的索引移除，这样就只保持了对刚刚移出屏幕 header 的追踪
        for attribute in layoutAttributes {
            if let kind = attribute.representedElementKind {
                if kind == UICollectionElementKindSectionHeader {
                    headersNeedingLayout.removeIndex(attribute.indexPath.section)
                }
            }
        }
        
        // 将刚移出屏幕的 header 加入 layoutAttributes
        headersNeedingLayout.enumerateIndexesUsingBlock { (index, _) -> Void in
            let indexPath = NSIndexPath(forItem: 0, inSection: index)
            let attributes = self.layoutAttributesForSupplementaryViewOfKind(UICollectionElementKindSectionHeader, atIndexPath: indexPath)
            layoutAttributes.append(attributes)
        }
        
        
        // layoutAttributes 里保存着当前屏幕上所有元素 + 上一个 section header 的 attributes，接下来找出这两个 header 的 attributes
        for attribute in layoutAttributes {
            if let kind = attribute.representedElementKind {
                if kind == UICollectionElementKindSectionHeader {
                    let session = attribute.indexPath.section
                    let attributesForFirstItemInSection = layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: 0, inSection: session))
                    let attributesForLastItemInSection = layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: collectionView!.numberOfItemsInSection(session) - 1, inSection: session))
                    
                    var headerFrame = attribute.frame
                    let offset = collectionView!.contentOffset.y
                    let minY = CGRectGetMinY(attributesForFirstItemInSection.frame) - headerFrame.height
                    let maxY = CGRectGetMaxY(attributesForLastItemInSection.frame) - headerFrame.height
                    let y = min(max(minY, offset), maxY)
                    headerFrame.origin.y = y
                    attribute.frame = headerFrame
                    // 设置 header 在 z 轴上最上面
                    attribute.zIndex = 99
                }
            }
        }
        return layoutAttributes
    }
    
    // refresh layout when changes
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
}
