//
//  CollectionViewCell.swift
//  CollectionLine
//
//  Created by FanYu on 20/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView?
    var imageStr: NSString? {
        didSet {
            self.imageView?.image = UIImage(named: self.imageStr as! String)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // iamge view
        self.imageView = UIImageView()
        self.addSubview(imageView!)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imageView?.frame = self.bounds
    }
}

