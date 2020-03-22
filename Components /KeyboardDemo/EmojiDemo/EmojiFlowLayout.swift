//
//  EmojiFlowLayout.swift
//  EmojiDemo
//
//  Created by FanYu on 4/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class EmojiFlowLayout: UICollectionViewFlowLayout {

    override init() {
        super.init()
        
        self.itemSize = CGSize(width: 40, height: 40)
        self.scrollDirection = .Horizontal
        self.minimumInteritemSpacing = 5
        self.minimumLineSpacing = 5
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareLayout() {
    }
}
