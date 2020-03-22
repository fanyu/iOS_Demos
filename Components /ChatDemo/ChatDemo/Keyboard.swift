//
//  KeyboardExtension.swift
//  ChatDemo
//
//  Created by FanYu on 8/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Keyboard
extension ViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: "keyboardWillShow:", name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: "keyboardWillHide:", name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // show 
    func keyboardWillShow(_ notification: Notification) {
        guard let keyboardInfo = notification.userInfo else { return }
        let keyboardHeight = (keyboardInfo[UIKeyboardFrameBeginUserInfoKey] as AnyObject).cgRectValue.size.height
        
        // input view
        inputTextView.frame.origin.y = self.height - keyboardHeight - 44
        inputTextView.keyboardHeight = self.height - keyboardHeight

        // table view content offset
        self.tableView.contentOffset = CGPoint(x: 0, y: self.tableView.contentSize.height - self.height + 300)
    }
    
    // hide
    func keyboardWillHide(_ notification: Notification) {
        
        // input view
        inputTextView.frame.origin.y = self.height - 44
        
        // table view content offset
        self.tableView.contentOffset = CGPoint(x: 0, y: 0)
    }
}
