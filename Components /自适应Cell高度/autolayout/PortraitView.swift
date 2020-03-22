//
//  PortraitView.swift
//  autolayout
//
//  Created by FanYu on 22/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit
import SnapKit

class PortraitView: UIView {

    private(set) var contentView = UIImageView()
        
    var image: String? {
        didSet {
            contentView.image = UIImage(named: image!)
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        // image view
        contentView.clipsToBounds = true
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        // sub 
        self.addSubview(contentView)
        
        // constraint
        contentView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self).inset(UIEdgeInsetsMake(1, 1, 1, 1))
        }
    }
}
