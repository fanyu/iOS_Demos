//
//  EmojiCollectionViewCell.swift
//  EmojiDemo
//
//  Created by FanYu on 4/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class EmojiCollectionViewCell: UICollectionViewCell {
    
    var label: UILabel!
    var imageView: UIImageView!
    var imageStr: String! {
        didSet {
            self.imageView.image = UIImage(named: self.imageStr)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.imageView = UIImageView()
        self.addSubview(imageView)
        imageView.backgroundColor = UIColor.orangeColor()
        
        // label 
        self.label = UILabel()
        self.label.text = "3"
        self.label.textAlignment = .Center
        self.label.textColor = UIColor.blueColor()
        self.imageView.addSubview(label)
    }
    
    override func layoutSubviews() {
        imageView.frame = self.bounds
        self.label.frame = self.bounds  
    }
}
