//
//  NextViewController.swift
//  TextKitDemo
//
//  Created by FanYu on 6/21/16.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

struct Notes {
    static let content = "Shopping List\r\r1. Cheese\r2. Biscuits\r3. Sausages\r4. IMPORTANT CASh for going out!\r5. -potatoes-\r6. A copy of iOS8 by tutorials\r7. A new iPhone\r8. A present for mum"
}


class NextViewController: UIViewController {

    var textView: UITextView!
    var textStorage: SyntaxTextStorage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTextView()
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(NextViewController.preferredContentSizeChanged(_:)),
                                                         name: UIContentSizeCategoryDidChangeNotification,
                                                         object: nil)
    }
}



extension NextViewController: UITextViewDelegate {
    
    // 程序运行中，去切换了字体，这时候要进行更新 
    @objc private func preferredContentSizeChanged(notification: NSNotification) {
        textStorage.update()
    }
    
    private func createTextView() {
        // create the text storage 
        let attrs = [NSFontAttributeName : UIFont.preferredFontForTextStyle(UIFontTextStyleBody)]
        let attrString = NSAttributedString(string: Notes.content, attributes: attrs)
        
        textStorage = SyntaxTextStorage()
        textStorage.appendAttributedString(attrString)
        
        // create layout manager 
        let layoutManager = NSLayoutManager()
        
        // create container
        let container = NSTextContainer(size: CGSize(width: view.bounds.width, height: view.bounds.height))
        container.widthTracksTextView = true
    
        layoutManager.addTextContainer(container)
        textStorage.addLayoutManager(layoutManager)
        
        // create UITextView 
        textView = UITextView(frame: view.frame, textContainer: container)
        textView.delegate = self
        view.addSubview(textView)
    }
    
}



