//
//  PicturesCell.swift
//  autolayout
//
//  Created by FanYu on 25/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class PicturesCell: UITableViewCell {

    private(set) lazy var portraitView = PortraitView(frame: CGRectZero)
    private(set) lazy var titleView = TitleView(frame: CGRectZero)
    private(set) lazy var textView = TextView(frame: CGRectZero)
    private(set) lazy var pic1 = PortraitView(frame: CGRectZero)
    private(set) lazy var pic2 = PortraitView(frame: CGRectZero)
    private var didSetupConstraints = false
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("init")
        self.selectionStyle = .None
        setup()
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        // config
        portraitView.translatesAutoresizingMaskIntoConstraints = false
        titleView.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        pic1.translatesAutoresizingMaskIntoConstraints = false
        pic2.translatesAutoresizingMaskIntoConstraints = false
        
        // sub
        self.contentView.addSubview(portraitView)
        self.contentView.addSubview(titleView)
        self.contentView.addSubview(textView)
        self.contentView.addSubview(pic2)
        self.contentView.addSubview(pic1)
    }

    private func addConstraints() {
        // constrains
        portraitView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.contentView).offset(10)
            make.top.equalTo(self.contentView).offset(10)
            make.size.equalTo(CGSizeMake(50, 50))
        }
        
        titleView.snp_makeConstraints { (make) -> Void in
            make.height.equalTo(22)
            make.top.equalTo(self.contentView).offset(10)
            make.left.equalTo(portraitView.snp_right).offset(10)
            make.right.lessThanOrEqualTo(self.contentView).offset(-10)
        }
        
        textView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(titleView.snp_bottom).offset(10)
            //make.bottom.equalTo(self.contentView).offset(-10)
            make.left.equalTo(portraitView.snp_right).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
        }
        
        pic1.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSize(width: 80, height: 80))
            make.left.equalTo(portraitView.snp_right).offset(10)
            make.top.equalTo(textView.snp_bottom).offset(10)
            make.bottom.equalTo(self.contentView).offset(-10)
        }
        
        pic2.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSize(width: 80, height: 80))
            make.top.equalTo(textView.snp_bottom).offset(10)
            make.left.equalTo(pic1.snp_right).offset(10)
            make.right.lessThanOrEqualTo(self.contentView).offset(-10)
            make.bottom.equalTo(self.contentView).offset(-10)
        }
    }


}
