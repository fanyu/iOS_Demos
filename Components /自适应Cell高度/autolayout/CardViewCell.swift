//
//  CardViewCell.swift
//  autolayout
//
//  Created by FanYu on 25/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit
import SnapKit

class CardViewCell: UITableViewCell {

    private(set) lazy var portraitView = PortraitView(frame: CGRectZero)
    private(set) lazy var titleView = TitleView(frame: CGRectZero)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setup()
        self.addConstraints()
        
        self.selectionStyle = .Blue
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        portraitView.translatesAutoresizingMaskIntoConstraints = false
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(portraitView)
        self.contentView.addSubview(titleView)
    }
    
    private func addConstraints() {
        portraitView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView).offset(10)
            make.centerX.equalTo(self.contentView)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        titleView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(portraitView.snp_bottom).offset(10)
            make.bottom.equalTo(self.contentView).offset(-10)
            make.centerX.equalTo(self.contentView)
            make.height.equalTo(20)
        }
    }
    
    
//    override func updateConstraints() {
//        
//    }
}
