//
//  EnterView.swift
//  EmojiDemo
//
//  Created by FanYu on 4/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit


class InputFieldView: UIView, UITextViewDelegate {

    fileprivate let buttonWidth: CGFloat = 44
    fileprivate var width: CGFloat { return UIScreen.main.bounds.size.width }
    
    var textView: UITextView!
    var keyboardHeight: CGFloat = 0
    
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
    fileprivate func setup() {
        
        // self 
        self.backgroundColor = UIColor.white
        
        // text field 
        textView = UITextView(frame: CGRect(x: buttonWidth, y: 5, width: width - 3 * buttonWidth, height: buttonWidth - 10))
        textView.layer.cornerRadius = 5
        textView.delegate = self
        textView.font = UIFont.systemFont(ofSize: 16)
        //textView.scrollIndicatorInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 1)
        //textView.textContainerInset = UIEdgeInsets(top: 10, left: 3, bottom: 7, right: 0)
        textView.backgroundColor = UIColor.white
        textView.scrollsToTop = true
        textView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        self.addSubview(textView)
        
        // left button
        leftButton = UIButton(frame: CGRect(x: 0, y: 0, width: buttonWidth, height: buttonWidth))
        leftButton.setImage(UIImage(named: "Voice"), for: UIControlState())
        leftButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        leftButton.contentMode = .center
        //leftButton.addTarget(self, action: "leftButtonTapped", forControlEvents: .TouchUpInside)
        self.addSubview(leftButton)
        
        // right plus button
        rightPlusButton = UIButton(frame: CGRect(x: width - buttonWidth, y: 0, width: buttonWidth, height: buttonWidth))
        rightPlusButton.setImage(UIImage(named: "Plus"), for: UIControlState())
        rightPlusButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        rightPlusButton.contentMode = .center
        //rightPlusButton.addTarget(self, action: "rightPlusButtonTapped", forControlEvents: .TouchUpInside)
        self.addSubview(rightPlusButton)
        
        // right emoji button 
        rightEmojiButton = UIButton(frame: CGRect(x: width - 2 * buttonWidth, y: 0, width: buttonWidth, height: buttonWidth))
            rightEmojiButton.setImage(UIImage(named: "Emoji"), for: UIControlState())
        rightEmojiButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        rightEmojiButton.contentMode = .center
        //rightEmojiButton.addTarget(self, action: "rightEmojiButtonTapped", forControlEvents: .TouchUpInside)
        self.addSubview(rightEmojiButton)
    }
}


// MARK: - TextView Delegate
extension InputFieldView {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.becomeFirstResponder()
    }
}


// MARK: - Handler
extension InputFieldView {
        
    // observe value for key 
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard let object = object else { return }
        
        if (object as AnyObject).isEqual(self.textView) && keyPath == "contentSize" {
            let newHeight = inputBarHeight()
            
            // change frame
            self.frame = CGRect(x: self.frame.origin.x, y: self.keyboardHeight - newHeight , width: width, height: newHeight)
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
    
    fileprivate func inputBarHeight() ->CGFloat {
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
    
    
    fileprivate func currentHeightForLines(_ numberOfLines: Int) ->CGFloat {
        var height = 44 - (self.textView.font?.lineHeight)!
        let lineTotalHeight = (self.textView.font?.lineHeight)! * CGFloat(numberOfLines)
        height += round(lineTotalHeight)
        
        return height
    }
    
    fileprivate func numberOfLines() ->Int {
        let line = self.textView.contentSize.height / (self.textView.font?.lineHeight)!
        if line < 1 {
            return 1
        }
        return abs(Int(line))
    }
    
}

