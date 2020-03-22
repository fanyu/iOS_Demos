//
//  TableViewCell.swift
//  CellHeightIncrease
//
//  Created by FanYu on 30/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit
import SnapKit


protocol CellDelegate {
    func cellMoreButtonTapped(cell: TableViewCell)
}

class TableViewCell: UITableViewCell {

    private var title = TitleLabel()
    private var content = ContentLabel()
    private var button = MoreButton()
    private var hasAddedConstraint = false
    
    var heightConstrait: Constraint? = nil
    
    private var count: CGFloat = 0
    
    var loadMore: Bool = false
    var once: Bool = false
    
    var delegate: CellDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        //addConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        // self 
        self.selectionStyle = .None
        
        // trans
        self.title.translatesAutoresizingMaskIntoConstraints = false
        self.content.translatesAutoresizingMaskIntoConstraints = false
        self.button.translatesAutoresizingMaskIntoConstraints = false
        
        // sub 
        self.contentView.addSubview(title)
        self.contentView.addSubview(content)
        self.contentView.addSubview(button)
        
        // button event
        button.addTarget(self, action: "tapped:", forControlEvents: .TouchUpInside)
    }
    
    private func addConstraints() {
        // constraint
        // title
        title.snp_makeConstraints { (make) -> Void in
            make.height.equalTo(22)
            make.left.right.top.equalTo(self.contentView).inset(UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8))
        }
        // button
        button.snp_makeConstraints { (make) -> Void in
            make.height.equalTo(32)
            make.left.right.bottom.equalTo(self.contentView)
        }
        // content
        content.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(self.contentView).inset(UIEdgeInsets(top: 4, left: 10, bottom: 10, right: 8))
            make.top.equalTo(title.snp_bottom).offset(4)
            make.bottom.equalTo(button.snp_top).offset(-4)
            heightConstrait = make.height.equalTo(60).priorityHigh().constraint
        }
    }
    
    override func updateConstraints() {
        print("updateConstraints \(loadMore) \(count++)")
        
        if !hasAddedConstraint {
            addConstraints()
            hasAddedConstraint = true
        }
        
        if loadMore {
            heightConstrait?.uninstall()
            print("loadMore")
        } else {
            heightConstrait?.install()
            print("NoLoad")
        }
        
        super.updateConstraints()
    }
    
    
    // MARK: - Handler
    func tapped(sender: UIButton) {
        delegate?.cellMoreButtonTapped(self)
        //print(self)
    }
}

