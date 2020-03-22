//
//  ActionHandler.swift
//  ChatDemo
//
//  Created by FanYu on 8/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import Foundation
import UIKit


extension ViewController {
    
    // view tapped
    func viewTapped(_ sender: UITapGestureRecognizer) {
        inputTextView.textView.resignFirstResponder()
    }
    
    // input view button tapped 
    func leftButtonTapped() {
        print("left")
        if inputTextView.textView.isFirstResponder {
            inputTextView.textView.resignFirstResponder()
            inputTextView.leftButton.setImage(UIImage(named: "Keyboard"), for: UIControlState())
        } else {
            inputTextView.textView.becomeFirstResponder()
            inputTextView.leftButton.setImage(UIImage(named: "Voice"), for: UIControlState())
        }
    }
    
    func rightPlusButtonTapped() {
        // chat text 
//        if inputTextView.textView == "" {
//            return
//        }
        
        chatText.append(inputTextView.textView.text)
        inputTextView.textView.text = ""
        self.tableView.reloadData()
        self.tableView.contentOffset.y = self.tableView.contentSize.height + 30
        
        
        print(inputTextView.textView.text)
        //inputTextView.
        
    }
    
    func rightEmojiButtonTapped() {
        
    }

    // cell 
    func tapTextView(_ sender: UITapGestureRecognizer) {
        inputTextView.textView.resignFirstResponder()
    }
}

