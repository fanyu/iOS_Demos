//
//  CollectionReusableView.swift
//  
//
//  Created by FanYu on 9/5/15.
//
//

import UIKit

class CollectionViewHeader: UICollectionReusableView {
    
    @IBOutlet weak var backgroundImageView: UIView!
    @IBOutlet weak var backgroundHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var foregroundImageView: UIView!
    @IBOutlet weak var foregroundHeightConstraint: NSLayoutConstraint!
    
    var backgroundImageHeight: CGFloat?
    var foregroundImageHeight: CGFloat?
    var previousHeight: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundImageHeight = backgroundImageView.bounds.size.height
        foregroundImageHeight = foregroundImageView.bounds.size.height
    }
    
    // reload when layout changes
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
        let attributes = layoutAttributes as! MyAttributes
        let height = attributes.frame.size.height
        
        if previousHeight != height {
            backgroundHeightConstraint.constant = backgroundImageHeight! - attributes.deltaY
            foregroundHeightConstraint.constant = foregroundImageHeight! + attributes.deltaY
            previousHeight = height
        }
    }
}
