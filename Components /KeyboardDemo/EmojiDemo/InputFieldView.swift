//
//  EnterView.swift
//  EmojiDemo
//
//  Created by FanYu on 4/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit


class InputFieldView: UIView, UITextViewDelegate {

    private let buttonWidth: CGFloat = 44
    private var width: CGFloat { return UIScreen.mainScreen().bounds.size.width }
    
    private var textView: UITextView!
    
    var leftButton: UIButton!
    var rightPlusButton: UIButton!
    var rightEmojiButton: UIButton!
    var maxBarLines: Int = 4
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Setup
    private func setup() {
        
        // self 
        self.backgroundColor = UIColor.whiteColor()
        
        // text field 
        textView = UITextView(frame: CGRect(x: buttonWidth, y: 5, width: width - 3 * buttonWidth, height: buttonWidth - 10))
        textView.backgroundColor = UIColor.lightGrayColor()
        textView.layer.cornerRadius = 5
        textView.delegate = self
        textView.font = UIFont.systemFontOfSize(16)
        //textView.scrollIndicatorInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 1)
        //textView.textContainerInset = UIEdgeInsets(top: 10, left: 3, bottom: 7, right: 0)
        textView.backgroundColor = UIColor.orangeColor()
        textView.scrollsToTop = true
        textView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.New, context: nil)
        self.addSubview(textView)
        
        // left button
        leftButton = UIButton(frame: CGRect(x: 0, y: 0, width: buttonWidth, height: buttonWidth))
        leftButton.setImage(UIImage(named: "voice"), forState: .Normal)
        leftButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        leftButton.contentMode = .Center
        leftButton.addTarget(self, action: "leftButtonTapped", forControlEvents: .TouchUpInside)
        self.addSubview(leftButton)
        
        // right plus button
        rightPlusButton = UIButton(frame: CGRect(x: width - buttonWidth, y: 0, width: buttonWidth, height: buttonWidth))
        rightPlusButton.setImage(UIImage(named: "plus"), forState: .Normal)
        rightPlusButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        rightPlusButton.contentMode = .Center
        rightPlusButton.addTarget(self, action: "rightPlusButtonTapped", forControlEvents: .TouchUpInside)
        self.addSubview(rightPlusButton)
        
        // right emoji button 
        rightEmojiButton = UIButton(frame: CGRect(x: width - 2 * buttonWidth, y: 0, width: buttonWidth, height: buttonWidth))
        rightEmojiButton.setImage(UIImage(named: "emoji"), forState: .Normal)
        rightEmojiButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        rightEmojiButton.contentMode = .Center
        rightEmojiButton.addTarget(self, action: "rightEmojiButtonTapped", forControlEvents: .TouchUpInside)
        self.addSubview(rightEmojiButton)
    }
}


// MARK: - Handler
extension InputFieldView {
    func leftButtonTapped() {
        print("left")
    }
    
    func rightPlusButtonTapped() {
        
    }
    
    func rightEmojiButtonTapped() {
        
    }
    
    // observe value for key 
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        guard let object = object else { return }
        
        if object.isEqual(self.textView) && keyPath == "contentSize" {
            let newHeight = inputBarHeight()
            
            // change frame
            self.frame = CGRect(x: self.frame.origin.x, y: 300 - newHeight, width: width, height: newHeight)
            // make textview center
            self.textView.frame.size.height = newHeight - 10
            // make button at the bottom
            self.leftButton.frame.origin.y = newHeight - 44
            self.rightPlusButton.frame.origin.y = newHeight - 44
            self.rightEmojiButton.frame.origin.y = newHeight - 44
        }
    }
}


// MARK: - Helper
extension InputFieldView {
    
    private func inputBarHeight() ->CGFloat {
        var height: CGFloat = 0.0
        
        if numberOfLines() == 1 {
            height = 44
        } else if numberOfLines() <= maxBarLines {
            height = currentHeightForLines(numberOfLines())
        } else {
            height = currentHeightForLines(maxBarLines)
        }
        
        return height
    }
    
    
    private func currentHeightForLines(numberOfLines: Int) ->CGFloat {
        var height = 44 - (self.textView.font?.lineHeight)!
        let lineTotalHeight = (self.textView.font?.lineHeight)! * CGFloat(numberOfLines)
        height += round(lineTotalHeight)
        
        return height
    }
    
    private func numberOfLines() ->Int {
        let line = self.textView.contentSize.height / (self.textView.font?.lineHeight)!
        if line < 1 {
            return 1
        }
        return abs(Int(line))
    }
    
}

