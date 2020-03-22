//
//  CollectionViewCell.swift
//  
//
//  Created by FanYu on 9/11/15.
//
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // refresh when cell has changed
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
        
        let standardHeight = UltraVisualConstant.standardHeight
        let featuredHeight = UltraVisualConstant.featuredHeight
        
        //standard cell height 增长到 featured cell height，delta 也会按比例由 0 到 1
        let delta = 1 - ((featuredHeight - CGRectGetHeight(self.frame)) / (featuredHeight - standardHeight))
        
        let minAlpha: CGFloat = 0.0     // 完全透明
        let maxAlpha: CGFloat = 0.75    // 有暗度
        
        // 透明度也会由 maxAlpha 变为 minAlpha 结果就是越明亮
        coverView.alpha = maxAlpha - (delta * (maxAlpha - minAlpha))
        
        // scale 不小于 0.5
        let scale = max(delta, 0.5)
        titleLabel.transform = CGAffineTransformMakeScale(scale, scale)
    }
    
}
