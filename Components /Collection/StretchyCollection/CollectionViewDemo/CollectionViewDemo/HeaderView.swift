//
//  HeaderView.swift
//  
//
//  Created by FanYu on 9/8/15.
//
//

import UIKit

class HeaderView: UICollectionReusableView {
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var backgroundHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var foregroundImageView: UIImageView!
    @IBOutlet weak var foregroundHeightConstraint: NSLayoutConstraint!
    
    var backgroundImageHeight: CGFloat?
    var foregroundImageHeight: CGFloat?
    var previousHeight: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundImageHeight = backgroundImageView.bounds.size.height
        foregroundImageHeight = foregroundImageView.bounds.size.height
    }
    
    // relaod when layout changes
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes!) {
        super.applyLayoutAttributes(layoutAttributes)
        
        let attribute = layoutAttributes as! MyLayoutAttributes
        let currentHeight = attribute.frame.size.height
        
        if currentHeight != previousHeight {
            backgroundHeightConstraint.constant = backgroundImageHeight! - attribute.deltaY
            foregroundHeightConstraint.constant = foregroundImageHeight! + attribute.deltaY
            previousHeight = currentHeight
        }
    }
}
