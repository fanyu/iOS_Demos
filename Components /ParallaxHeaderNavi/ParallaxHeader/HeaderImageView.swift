//
//  HeaderImageView.swift
//  ParallaxHeader
//
//  Created by FanYu on 28/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit
import SnapKit

class HeaderImageView: UIView {

    var imageStr: String? {
        didSet {
            contentView.image = UIImage(named: imageStr!)
        }
    }
    
    let height: CGFloat = 200
    private lazy var contentView = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func setup() {
        // self
        self.clipsToBounds = true
        
        // content 
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.contentMode = .ScaleAspectFill
        
        // sub 
        self.addSubview(contentView)
        
        // constraint 
        contentView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
}
