//
//  MyLayout.swift
//  
//
//  Created by FanYu on 9/4/15.
//
//

import UIKit

class MyAttributes: UICollectionViewLayoutAttributes {
    var deltaY: CGFloat = 0
    
    override func copyWithZone(zone: NSZone) -> AnyObject {
        let copy = super.copyWithZone(zone) as! MyAttributes
        copy.deltaY = deltaY
        return copy
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        if let attributes = object as? MyAttributes {
            if attributes.deltaY == deltaY {
                return super.isEqual(object)
            }
        }
        return false
    }
}


class MyLayout: UICollectionViewFlowLayout {
    
    var maximumStretchHeight: CGFloat = 0

    override class func layoutAttributesClass() -> AnyClass {
        return MyAttributes.self
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElementsInRect(rect) as! [MyAttributes]
        let insets = collectionView!.contentInset
        let offset = collectionView!.contentOffset
        let minY = -insets.top
        
        if offset.y < minY {
            let deltaY = fabs(offset.y - minY)
            for attribute in layoutAttributes {
                if let elementKind = attribute.representedElementKind {
                    if elementKind == UICollectionElementKindSectionHeader {
                        var frame = attribute.frame
                        // extend frame hight
                        frame.size.height = min(max(minY, headerReferenceSize.height + deltaY), maximumStretchHeight)
                        // reset original as top - 0
                        frame.origin.y = CGRectGetMinY(frame) - deltaY
                        attribute.frame = frame
                        attribute.deltaY = deltaY
                    }
                }
            }
        }
        
        return layoutAttributes
    }
    
    // reload view after changed 
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
}


