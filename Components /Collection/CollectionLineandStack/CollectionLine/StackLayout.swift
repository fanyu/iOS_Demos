//
//  StackLayout.swift
//  CollectionLine
//
//  Created by FanYu on 21/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class StackLayout: UICollectionViewLayout {
    
    let itemWidth: CGFloat = 200
    let itemHeight: CGFloat = 200
    
    //在继承自UICollectionViewFlowLayout时，苹果已经帮我们声明了这个属性
    var itemSize: CGSize
    let showItemNumber: Int = 5
    let angles: [CGFloat] = [0, 0.2, -0.5, 0.2, 0.5]
    
    override init() {
        self.itemSize = CGSize(width: itemWidth, height: itemHeight)
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 因为这种布局期显示的边界从未发生变化，所以这里的返回值不会对程序产生什么影响
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return false
    }
    
    // 设置cell布局，size frame center tranform and etc...
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let cellAttribute = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        
        // 只为我们所需要显示的cell设置UICollectionViewLayoutAttributes
        if indexPath.item < showItemNumber {
            
            cellAttribute.center = CGPoint(x: self.collectionView!.frame.width * 0.5, y: self.collectionView!.frame.height * 0.5)
            cellAttribute.size = itemSize
            cellAttribute.transform = CGAffineTransformMakeRotation(angles[indexPath.item])
            
            //让第一张显示在最上面
            cellAttribute.zIndex = self.collectionView!.numberOfItemsInSection(0) - indexPath.item
            cellAttribute.hidden = false
            
        } else {
            cellAttribute.hidden = true
        }
        
        return cellAttribute
    }
    
    // 用来计算出rect这个范围内所有cell的UICollectionViewLayoutAttributes,并返回
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = [UICollectionViewLayoutAttributes]()
        
        //为需要显示的cell创建UICollectionViewLayoutAttributes,这里设置的是显示5个
        for i in 0 ..< showItemNumber {
            let attr = self.layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: i, inSection: 0))
            attributes.append(attr!)
        }
        return attributes
    }
}
