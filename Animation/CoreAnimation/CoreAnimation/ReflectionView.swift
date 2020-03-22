//
//  ReflectionView.swift
//  CoreAnimation
//
//  Created by FanYu on 10/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class ReflectionView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //setup()
    }
    
    func setup() {
        var replicator = CAReplicatorLayer()
        replicator.instanceCount = 2
        
        // transform 3D 
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, 0, self.bounds.width, 0)
        transform = CATransform3DScale(transform, 1, -1, 0)
        replicator.transform = transform
        
        replicator.instanceAlphaOffset = -0.6
        layer.addSublayer(replicator)
        
    }

    override func awakeFromNib() {
        setup()
    }
}
