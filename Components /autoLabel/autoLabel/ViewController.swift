//
//  ViewController.swift
//  autoLabel
//
//  Created by FanYu on 16/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private(set) var label = UILabel()
    private(set) var label2 = UILabel()
    private(set) var textView = UITextView()
    var rightConstraint: NSLayoutConstraint!
    
    @IBAction func switchTapped(sender: UISwitch) {
        if sender.on {
            rightConstraint.priority = 50
        } else {
            rightConstraint.priority = 300
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func setup() {
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(20)
        label.textColor = UIColor.blueColor()
        label.backgroundColor = UIColor.lightGrayColor()
        // max width
        label.preferredMaxLayoutWidth = 200
        // multiple lines
        label.numberOfLines = 0
        // auto layout
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "天地玄黄 宇宙洪荒"
        
        self.view.addSubview(label)
        
        // constraint
        //view.addConstraints([NSLayoutConstraint(item: label, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1, constant: 100)])
        
        //view.addConstraints([NSLayoutConstraint(item: label, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1, constant: 20)])
        // constraint with priorith
        
        let topConstraint = NSLayoutConstraint(item: self.label, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1, constant: 100)
        
        let leftConstaint = NSLayoutConstraint(item: self.label, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1, constant: 20)
        leftConstaint.priority = 100
        
        rightConstraint = NSLayoutConstraint(item: self.label, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1, constant: -50)
        rightConstraint.priority = 50
        
        view.addConstraints([topConstraint, leftConstaint, rightConstraint])
        
        
        
        
        
        // label 
        label2.textAlignment = .Center
        label2.font = UIFont.systemFontOfSize(20)
        label2.textColor = UIColor.orangeColor()
        label2.backgroundColor = UIColor.yellowColor()
        label2.preferredMaxLayoutWidth = 200
        label2.numberOfLines = 0
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.text = "天地玄黄 宇宙洪荒 日月盈昃 辰宿列张"
        self.view.addSubview(label2)
        
        
        // text view
        textView.textAlignment = .Center
        textView.backgroundColor = UIColor.blueColor()
        textView.textColor = UIColor.whiteColor()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "天地玄黄 宇宙洪荒 日月盈昃 辰宿列张"
        
        self.view.addSubview(textView)
        
        self.view.addConstraints([NSLayoutConstraint(item: textView, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1, constant: 200)])
        self.view.addConstraints([NSLayoutConstraint(item: self.textView, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1, constant: 40)])
        
        // deside the width of the textView
        let size = textView.sizeThatFits(CGSize(width: 30, height: 0))
        self.view.addConstraints([NSLayoutConstraint(item: self.textView, attribute: .Width, relatedBy: .Equal, toItem: .None, attribute: .Width, multiplier: 1, constant: size.width)])
        self.view.addConstraints([NSLayoutConstraint(item: self.textView, attribute: .Height, relatedBy: .Equal, toItem: .None, attribute: .Height, multiplier: 1, constant: size.height)])
        print("size\(size)")
    }
    
    
    override func viewWillLayoutSubviews() {
        print(self.textView.frame)
    }
    
    override func viewDidLayoutSubviews() {
        print(self.textView.frame)
    }
}



class edcLabel: UILabel {
    
    override func intrinsicContentSize() -> CGSize {
        var size = super.intrinsicContentSize()
        size.width += 20
        size.height += 20
        print(size)
        return size
    }
}


class edcTextView: UITextView {
    
    override func sizeThatFits(size: CGSize) -> CGSize {
        return CGSizeMake(100, 100)
    }
}
