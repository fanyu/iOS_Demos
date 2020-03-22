//
//  ScrollExtension.swift
//  ChatDemo
//
//  Created by FanYu on 8/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import Foundation
import UIKit

// 
extension ViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        print(scrollView.contentOffset.y)
        if self.lastContentOffset > scrollView.contentOffset.y  {
            inputTextView.textView.resignFirstResponder()
        }
        
        lastContentOffset = scrollView.contentOffset.y
    }
}
