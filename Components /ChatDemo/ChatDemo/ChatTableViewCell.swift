//
//  ChatTableViewCell.swift
//  ChatDemo
//
//  Created by FanYu on 7/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    var screenWidth: CGFloat { return UIScreen.main.bounds.size.width }
    var screenHeight: CGFloat { return UIScreen.main.bounds.size.height }
    
    let horiSpace: CGFloat = 60
    let vertSpace: CGFloat = 10
    let defaultTextViewHeight: CGFloat = 44
    
    var leftImage: UIImageView!
    var rightImage: UIImageView!
    var textView: UITextView!
    
    var height: CGFloat = 0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // self 
        self.backgroundColor = UIColor.clear
        
        // image view 
        leftImage = UIImageView(frame: CGRect(x: 8, y: 10, width: defaultTextViewHeight, height: defaultTextViewHeight))
        leftImage.image = UIImage(named: "left")
        self.addSubview(leftImage)
        
        rightImage = UIImageView(frame: CGRect(x: screenWidth - 52, y: 10, width: defaultTextViewHeight, height: defaultTextViewHeight))
        rightImage.image = UIImage(named: "right")
        self.addSubview(rightImage)
        
        // text View
        textView = UITextView(frame: CGRect(x: horiSpace, y: vertSpace, width: screenWidth - 2 * horiSpace, height: defaultTextViewHeight))
        textView.backgroundColor = UIColor.white
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.isEditable = false
        textView.textContainerInset = UIEdgeInsets(top: 5, left: 1, bottom: 0, right: 1)
        textView.layer.cornerRadius = 6
        
        
        self.addSubview(textView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


extension ChatTableViewCell {
    
}

