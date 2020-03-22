//
//  MyLayout.swift
//  
//
//  Created by FanYu on 9/12/15.
//
//

import UIKit

func degreeToRadians(degree: Double) ->CGFloat {
    return CGFloat(M_PI * (degree / 180.0))
}

class MyLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = super.layoutAttributesForElementsInRect(rect) as! [UICollectionViewLayoutAttributes]
        
        for attributes in layoutAttributes {
            let frame = attributes.frame
            // 将view旋转15度
            attributes.transform = CGAffineTransformMakeRotation(degreeToRadians(-14))
            // 返回一个同中心的 放大或缩小后的 rect
            attributes.frame = CGRectInset(frame, 11, 0)
        }
        return layoutAttributes
    }
    
}
