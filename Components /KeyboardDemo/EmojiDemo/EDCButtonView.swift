//
//  EDCToolbar.swift
//  EmojiDemo
//
//  Created by FanYu on 4/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit


class EDCButtonView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var width: CGFloat { return UIScreen.mainScreen().bounds.size.width }
    var height: CGFloat { return UIScreen.mainScreen().bounds.size.height }
    
    var keyboardView: UIView!
    var textField: UITextField!
    
    var imageButton: UIButton!
    var atButton: UIButton!
    var numberButton: UIButton!
    var emojiButton: UIButton!
    var plusButton: UIButton!
    
    init(frame: CGRect, keyboardView: UIView, textField: UITextField) {
        super.init(frame: frame)
        self.keyboardView = keyboardView
        self.textField = textField
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        // self
        self.backgroundColor = UIColor.whiteColor()
        self.clipsToBounds = true
        
        // line view 
        let topLineView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 1))
        topLineView.backgroundColor = UIColor.lightGrayColor()
        self.addSubview(topLineView)
        
        let bottomLineView = UIView(frame: CGRect(x: 0, y: 44 - 1, width: width, height: 1))
        bottomLineView.backgroundColor = UIColor.lightGrayColor()
        self.addSubview(bottomLineView)
        
        let itemWidth: CGFloat = self.width / 5.0
        let itemHeight: CGFloat = 44
        
        // image button
        imageButton = UIButton(frame: CGRect(x: 0, y: 1, width: itemWidth, height: itemHeight))
        imageButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        imageButton.setImage(UIImage(named: "btn_image"), forState: .Normal)
        //imageButton.addTarget(self, action: "imageButtonTapped", forControlEvents: .TouchUpInside)
        imageButton.contentMode = .Center
        self.addSubview(imageButton)
        
        // @ button
        atButton = UIButton(frame: CGRect(x: itemWidth, y: 1, width: itemWidth, height: itemHeight))
        atButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        atButton.setImage(UIImage(named: "btn_@"), forState: .Normal)
        atButton.contentMode = .Center
        self.addSubview(atButton)
        
        // # button
        numberButton = UIButton(frame: CGRect(x: itemWidth * 2, y: 1, width: itemWidth, height: itemHeight))
        numberButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        numberButton.setImage(UIImage(named: "btn_num"), forState: .Normal)
        numberButton.contentMode = .Center
        self.addSubview(numberButton)
        // 😀 button
        emojiButton = UIButton(frame: CGRect(x: itemWidth * 3, y: 1, width: itemWidth, height: itemHeight))
        emojiButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        emojiButton.setImage(UIImage(named: "btn_emoji"), forState: .Normal)
        emojiButton.contentMode = .Center
        self.addSubview(emojiButton)
        
        // + button
        plusButton = UIButton(frame: CGRect(x: itemWidth * 4, y: 1, width: itemWidth, height: itemHeight))
        plusButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        plusButton.setImage(UIImage(named: "btn_plus"), forState: .Normal)
        plusButton.contentMode = .Center
        self.addSubview(plusButton)
    }
    
    
}
