//
//  MyLayout.swift
//  
//
//  Created by FanYu on 9/8/15.
//
//

import UIKit

class MyLayoutAttributes: UICollectionViewLayoutAttributes {
    var deltaY: CGFloat = 0
    
    override func copyWithZone(zone: NSZone) -> AnyObject {
        let copy = super.copyWithZone(zone) as! MyLayoutAttributes
        copy.deltaY = deltaY
        return copy
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        let attributes = object as! MyLayoutAttributes
        if attributes.deltaY == deltaY {
            return super.isEqual(object)
        }
        return false
    }
}

class MyLayout: UICollectionViewFlowLayout {
    
    var maximumStretchHeight: CGFloat = 0
    
    override class func layoutAttributesClass() -> AnyClass {
        return MyLayoutAttributes.self
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        let layoutAttributes = super.layoutAttributesForElementsInRect(rect) as! [MyLayoutAttributes]
        let offset = collectionView!.contentOffset
        let insets = collectionView!.contentInset
        let minY = -insets.top
                
        if offset.y < minY {
            let deltaY = fabs(offset.y - minY)
            for attribute in layoutAttributes {
                if let elementKind = attribute.representedElementKind {
                    if elementKind == UICollectionElementKindSectionHeader {
                        var frame = attribute.frame
                        // change hight
                        frame.size.height = min(max(minY, headerReferenceSize.height + deltaY), maximumStretchHeight)
                        // reset original
                        frame.origin.y = frame.minY - deltaY
                        attribute.frame = frame
                        // pass the deltaY
                        attribute.deltaY = deltaY
                    }
                }
            }
        }
        return layoutAttributes
    }
    
    // layout update
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
}
