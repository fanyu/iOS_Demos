//
//  TableViewCell.swift
//  RounderCorner
//
//  Created by FanYu on 1/3/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        label.text = "Hello"
        //label.layer.cornerRadius = 5
        //label.layer.masksToBounds = true
        label.backgroundColor = UIColor.clearColor()
        label.FYAddCorner(radius: 5, borderWidth: 1, borderColor: UIColor.blackColor(), backgroundColor: UIColor.clearColor())
        
        colorView.layer.cornerRadius = 5
        
        image1.layer.cornerRadius = 20
        //image2.layer.cornerRadius = 10
        //image1.FYAddCorner(radius: 20)
        image2.FYAddCorner(radius: 10)
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
