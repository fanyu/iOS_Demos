//
//  MyCollectionViewCell.swift
//  
//
//  Created by FanYu on 9/12/15.
//
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageViewCenterYLayoutConstaint: NSLayoutConstraint!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clipsToBounds = false
        self.addConstraint(NSLayoutConstraint(item: self,
                                         attribute: NSLayoutAttribute.Trailing,
                                         relatedBy: NSLayoutRelation.Equal,
                                            toItem: self.superview,
                                         attribute: NSLayoutAttribute.Trailing,
                                        multiplier: 1,
                                          constant: 0))
    }
    
    var parallaxOffset: CGFloat = 0 {
        didSet {
            imageViewCenterYLayoutConstaint.constant = parallaxOffset
        }
    }
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
        
        // 把图片扭正了
        backgroundImage.transform = CGAffineTransformMakeRotation(degreeToRadians(14))
    }
    
    
    // 更新图片偏移量
    func updateParallaxOffset(collectionViewBounds bounds: CGRect) {
        let center = CGPoint(x: CGRectGetMidX(bounds), y: CGRectGetMidY(bounds))
        let offsetFromCenter = CGPoint(x: center.x - self.center.x, y: center.y - self.center.y)
        print("\(self.center.y)")
        let maxVerticalOffset = CGRectGetHeight(bounds) / 2 + CGRectGetHeight(self.bounds) / 2
        let scaleFactor = 40 / maxVerticalOffset
        
        parallaxOffset = -offsetFromCenter.y * scaleFactor
    }
    
}
