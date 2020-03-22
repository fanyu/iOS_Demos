//
//  TimeLineTableViewCell.swift
//  TimeLine
//
//  Created by FanYu on 9/6/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

class TimeLineTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var chatImage: UIImageView!
    @IBOutlet weak var upperLineView: UIView!
    @IBOutlet weak var bottomLineView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        chatImage.image = UIImage(named: highlighted ? "chat_gray" : "chat")
        titleLabel.textColor = highlighted ? UIColor.blackColor() : UIColor.whiteColor()
    }
    
}
